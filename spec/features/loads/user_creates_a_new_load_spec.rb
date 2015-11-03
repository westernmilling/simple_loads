require 'rails_helper'

feature 'user creates a new load' do
  context 'when the load is valid' do
    given(:attributes) { OpenStruct.new(attributes_for(:load)) }

    scenario 'the new load is shown' do
      visit new_load_path

      fill_in :load_customer_name, with: attributes.customer_name
      fill_in :load_customer_location, with: attributes.customer_location
      fill_in :load_order_number, with: attributes.order_number
      fill_in :load_origin_location, with: attributes.origin_location
      fill_in :load_product_description, with: attributes.product_description
      fill_in :load_requested_date, with: attributes.requested_date

      click_on I18n.t('loads.new.submit')

      expect(page).to have_content(I18n.t('loads.create.success'))
      expect(page).to have_content(I18n.t('loads.show.title'))
      expect(page).to have_content(attributes.customer_name)
      expect(page).to have_content(attributes.customer_location)
      expect(page).to have_content(attributes.origin_location)
      expect(page).to have_content(attributes.product_description)
      expect(page).to have_content(attributes.requested_date)
      expect(page).to have_content(attributes.status)
    end
  end

  context 'when the load is not valid' do
    given(:attributes) do
      OpenStruct.new(attributes_for(:load, customer_name: nil))
    end

    scenario 'the erroneous details are shown' do
      visit new_load_path

      fill_in :load_customer_name, with: attributes.customer_name
      fill_in :load_customer_location, with: attributes.customer_location
      fill_in :load_order_number, with: attributes.order_number
      fill_in :load_origin_location, with: attributes.origin_location
      fill_in :load_product_description, with: attributes.product_description
      fill_in :load_requested_date, with: attributes.requested_date

      click_on I18n.t('loads.new.submit')

      expect(page).to have_content('error')
      expect(page).to_not have_content(I18n.t('loads.create.success'))
    end
  end
end
