require 'rails_helper'

RSpec.describe DispatchLoadEntry, type: :model do
  it { is_expected.to validate_presence_of :carrier_name }
  it { is_expected.to validate_presence_of :driver_name }

  describe 'attributes' do
    subject { described_class.new.attributes }
    its(:keys) { is_expected.to include :carrier_name, :driver_name }
  end
end
