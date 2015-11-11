class ShipLoad
  def initialize(load)
    @load = load
  end

  def ship(object)
    return false unless check_load_status

    @load.ship_date     = object.ship_date
    @load.weight_gross  = object.weight_gross
    @load.weight_net    = object.weight_net
    @load.weight_tare   = object.weight_tare

    @load.status = :shipped
    return false unless @load.save

    true
  end

  def load
    @load
  end

  def check_load_status
    load.status == :dispatched
  end
end
