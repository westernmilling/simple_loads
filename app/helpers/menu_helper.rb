module MenuHelper
  def menu
    content_tag 'ul', class: 'nav navbar-nav navbar-right' do
      menu_item(I18n.t('loads.index.title'), loads_path)
    end
  end

  protected

  def menu_item(name, path, options = nil)
    content_tag('li') do
      link_to name, path, options
    end
  end
end
