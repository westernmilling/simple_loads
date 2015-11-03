require 'rails_helper'

RSpec.describe MenuHelper, type: :helper do
  describe '#menu' do
    subject { helper.menu }

    it { is_expected.to have_selector 'ul' }
    it { is_expected.to have_selector 'ul li', count: 1 }
    it { is_expected.to have_selector 'ul li a', count: 1 }
    it { is_expected.to have_content I18n.t('loads.index.title') }
  end
end
