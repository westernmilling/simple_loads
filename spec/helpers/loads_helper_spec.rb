require 'rails_helper'

RSpec.describe LoadsHelper, type: :helper do
  describe '#link_to_dispatch' do
    subject { helper.link_to_dispatch(load) }

    context 'when the load status is new' do
      let(:load) { build_stubbed(:load, status: :new) }

      it do
        is_expected
          .to eq link_to(I18n.t('loads.dispatch.edit.link_to'),
                         load_dispatch_path(load),
                         class: 'btn btn-link')
      end
    end

    context 'when the load status is not new' do
      let(:load) { build_stubbed(:load, status: :dispatched) }

      it { is_expected.to be_blank }
    end
  end
end
