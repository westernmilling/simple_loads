class ShipLoad
  def initialize(load)
    @load = load
  end

  def ship(object)
    return false unless @load.dispatched?

    @load.ship_date     = object.ship_date
    @load.weight_gross  = object.weight_gross
    @load.weight_net    = object.weight_net
    @load.weight_tare   = object.weight_tare

    @load.ship!
  end

  def load
    @load
  end
end
