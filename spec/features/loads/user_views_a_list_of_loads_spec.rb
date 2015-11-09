require 'rails_helper'

feature 'user views a list of loads' do
  context 'when there are loads' do
    given!(:loads) { create_list(:load, 3) }

    scenario 'the loads are shown' do
      visit loads_path

      expect(page).to have_content(I18n.t('loads.index.title'))
      expect_load_row loads[0]
      expect_load_row loads[1]
      expect_load_row loads[2]
    end
  end

  context 'when there are no loads' do
    scenario 'no loads are shown' do
      visit loads_path

      expect(page).to have_content(I18n.t('loads.index.title'))
      expect(page).to have_content(I18n.t('loads.index.none_found'))
    end
  end
end

def expect_load_row(load)
  expect(page).to have_content(load.customer_name)
  expect(page).to have_content(load.customer_location)
  expect(page).to have_content(load.origin_location)
  expect(page).to have_content(load.product_description)
  expect(page).to have_content(load.requested_date)
  expect(page).to have_content(load.status)
end
