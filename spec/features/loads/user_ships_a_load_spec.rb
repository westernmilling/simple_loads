require 'rails_helper'

feature 'user ships a load' do
  given(:load) { create(:load, status: :dispatched) }
  given(:shipped_load) { create(:load, status: :shipped) }

  scenario 'the load is shipped' do
    visit load_ship_path(load)

    fill_in :entry_ship_date, with: 'sdf'
    fill_in :entry_weight_gross, with: 'sf'
    fill_in :entry_weight_net, with: 'sf'
    fill_in :entry_weight_tare, with: 'df'

    click_on I18n.t('loads.ship.edit.submit')

    expect(page).to have_content(I18n.t('loads.ship.update.success'))
  end

  context 'with a previously shipped load' do
    scenario 'an error is returned' do
      visit load_ship_path(shipped_load)

      fill_in :entry_ship_date, with: '11/06/2015'
      fill_in :entry_weight_gross, with: 3
      fill_in :entry_weight_net, with: 1
      fill_in :entry_weight_tare, with: 0

      click_on I18n.t('loads.ship.edit.submit')

      expect(page).to have_content(I18n.t('loads.ship.update.failure'))
    end
  end

  context 'with missing ship date' do
    scenario 'an error is returned' do
      visit load_ship_path(load)

      fill_in :entry_weight_gross, with: 3
      fill_in :entry_weight_net, with: 1
      fill_in :entry_weight_tare, with: 0

      click_on I18n.t('loads.ship.edit.submit')

      expect(page).to have_content("Ship date can't be blank")
    end
  end
end
