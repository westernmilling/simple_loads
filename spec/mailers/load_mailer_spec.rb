require 'rails_helper'

RSpec.describe LoadMailer, type: :mailer do
  describe 'dispatched' do
    let(:load) do
      build_stubbed(:load,
                    carrier_name: Faker::Company.name,
                    driver_name: Faker::Name.name)
    end
    let(:mail) { LoadMailer.dispatched(load) }

    subject { mail }

    its(:subject) do
      is_expected.to eq I18n.t('load_mailer.dispatched.subject')
    end
    its(:from) { is_expected.to eq [Figaro.env.MAILER_SENDER] }
    its(:to) { is_expected.to eq [Figaro.env.LOAD_MAILER_RECIPIENTS] }
    describe 'body.encoded' do
      subject { mail.body.encoded }

      it { is_expected.to match load.id.to_s }
      it { is_expected.to match load.order_number.to_s }
      it { is_expected.to match load.carrier_name }
      it { is_expected.to match load.driver_name }
    end
  end
end
