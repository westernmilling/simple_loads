class ShipLoadEntry < FormEntry
  attribute :ship_date, DateTime
  attribute :weight_gross, Integer
  attribute :weight_net, Integer
  attribute :weight_tare, Integer

  validates \
    :ship_date,
    :weight_gross,
    :weight_net,
    :weight_tare,
    presence: true
end
