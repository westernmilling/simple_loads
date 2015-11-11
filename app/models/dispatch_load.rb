class DispatchLoad
  attr_reader :load

  def initialize(load)
    @load = load
  end

  def dispatch(object)
    check_load_status

    @load.carrier_name = object.carrier_name
    @load.driver_name = object.driver_name
    @load.status = :dispatched

    return false unless @load.save

    LoadMailer.dispatched(load).deliver_now

    true
  end

  def check_load_status
    fail I18n.t('dispatch_load.errors.dispatched') \
      if load.dispatched?

    fail I18n.t('dispatch_load.errors.shipped') \
      if load.shipped?
  end
end
