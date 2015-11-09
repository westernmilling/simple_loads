require 'rails_helper'

feature 'user edits an existing load' do
  given(:load) { create(:load) }
  given(:carrier_name) { Faker::Company.name }
  given(:driver_name) { Faker::Name.name }
  given(:requested_date) { Date.current + 1.day }
  given(:ship_date) { Date.current + 2.days }
  given(:status) { Load.status.values.reject { |x| x == load.status }.sample }

  context 'when the load details are valid' do
    given(:attributes) { OpenStruct.new(attributes_for(:load)) }

    scenario 'the updated load is shown' do
      visit edit_load_path(load)

      fill_in :load_customer_name, with: attributes.customer_name
      fill_in :load_customer_location, with: attributes.customer_location
      fill_in :load_carrier_name, with: carrier_name
      fill_in :load_driver_name, with: driver_name
      fill_in :load_order_number, with: attributes.order_number
      fill_in :load_origin_location, with: attributes.origin_location
      fill_in :load_product_description, with: attributes.product_description
      fill_in :load_requested_date, with: requested_date
      fill_in :load_ship_date, with: ship_date
      select status, from: :load_status

      click_on I18n.t('loads.edit.submit')

      expect(page).to have_content(I18n.t('loads.update.success'))
      expect(page).to have_content(I18n.t('loads.show.title'))
      expect(page).to have_content(attributes.customer_name)
      expect(page).to have_content(attributes.customer_location)
      expect(page).to have_content(carrier_name)
      expect(page).to have_content(driver_name)
      expect(page).to have_content(attributes.origin_location)
      expect(page).to have_content(attributes.product_description)
      expect(page).to have_content(requested_date)
      expect(page).to have_content(ship_date)
      expect(page).to have_content(status)
      expect(page).to_not have_content(load.customer_name)
      expect(page).to_not have_content(load.customer_location)
      expect(page).to_not have_content(load.origin_location)
      expect(page).to_not have_content(load.product_description)
      expect(page).to_not have_content(load.requested_date)
      expect(page).to_not have_content(load.status)
    end
  end

  context 'when the load details are not valid' do
    given(:attributes) do
      OpenStruct.new(attributes_for(:load, customer_name: nil))
    end

    scenario 'the updated load is shown' do
      visit edit_load_path(load)

      fill_in :load_customer_name, with: attributes.customer_name
      fill_in :load_customer_location, with: attributes.customer_location
      fill_in :load_carrier_name, with: carrier_name
      fill_in :load_driver_name, with: driver_name
      fill_in :load_order_number, with: attributes.order_number
      fill_in :load_origin_location, with: attributes.origin_location
      fill_in :load_product_description, with: attributes.product_description
      fill_in :load_requested_date, with: requested_date
      fill_in :load_ship_date, with: ship_date
      select status, from: :load_status

      click_on I18n.t('loads.edit.submit')

      expect(page).to have_content('errors')
      expect(page).to have_content(I18n.t('loads.edit.title'))
    end
  end
end
