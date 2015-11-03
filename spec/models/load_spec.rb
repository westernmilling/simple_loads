require 'rails_helper'

RSpec.describe Load, type: :model do
  it { is_expected.to validate_presence_of :customer_name }
  it { is_expected.to validate_presence_of :customer_location }
  it { is_expected.to validate_presence_of :order_number }
  it { is_expected.to validate_presence_of :origin_location }
  it { is_expected.to validate_presence_of :product_description }
  it { is_expected.to validate_presence_of :requested_date }
  it { is_expected.to validate_presence_of :status }
  it do
    is_expected
      .to enumerize(:status).in(:new, :dispatched, :shipped).with_default(:new)
  end

  describe 'not stubbed' do
    subject { create(:load) }

    it { is_expected.to validate_uniqueness_of :order_number }
  end

  describe '.new' do
    subject { Load.new }

    its(:status) { is_expected.to eq :new }
  end
end
