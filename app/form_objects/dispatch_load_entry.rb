class DispatchLoadEntry < FormEntry
  attribute :carrier_name, String
  attribute :driver_name, String

  validates \
    :carrier_name,
    :driver_name,
    presence: true
end
