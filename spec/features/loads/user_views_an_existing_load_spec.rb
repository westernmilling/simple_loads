require 'rails_helper'

feature 'user views an existing load' do
  context 'when the load exists' do
    given(:load) { create(:load) }

    scenario 'the load is shown' do
      visit load_path(load)

      expect(page).to have_content(I18n.t('loads.show.title'))
      expect(page).to have_content(load.customer_name)
      expect(page).to have_content(load.customer_location)
      expect(page).to have_content(load.origin_location)
      expect(page).to have_content(load.product_description)
      expect(page).to have_content(load.requested_date)
      expect(page).to have_content(load.status)
    end
  end
end
