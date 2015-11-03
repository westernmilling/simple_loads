module LoadsHelper
  def link_to_dispatch(load)
    return nil if load.status != :new

    link_to I18n.t('loads.dispatch.edit.link_to'),
            load_dispatch_path(load),
            class: 'btn btn-link'
  end
end
