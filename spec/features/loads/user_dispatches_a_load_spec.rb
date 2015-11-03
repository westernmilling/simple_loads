require 'rails_helper'

feature 'user dispatches a load' do
  given(:carrier_name) { Faker::Company.name }
  given(:driver_name) { Faker::Name.name }
  given(:load) { create(:load) }

  scenario 'the dispatched load is shown' do
    visit load_dispatch_path(load)

    fill_in :entry_carrier_name, with: carrier_name
    fill_in :entry_driver_name, with: driver_name

    click_on I18n.t('loads.dispatch.edit.submit')

    expect(page).to have_content(I18n.t('loads.dispatch.update.success'))
    expect(page).to have_content(carrier_name)
    expect(page).to have_content(driver_name)
    expect(page).to have_content('dispatched')
  end
end
