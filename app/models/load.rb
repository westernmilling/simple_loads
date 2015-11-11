class Load < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:new, :dispatched, :shipped], default: :new

  validates \
    :customer_name,
    :customer_location,
    :order_number,
    :origin_location,
    :product_description,
    :requested_date,
    :status,
    presence: true
  validates \
    :order_number,
    uniqueness: true

  def self.drivers
    all.map(&:driver_name).compact
  end

  def self.by_requested_date
    order(:requested_date)
  end
end
