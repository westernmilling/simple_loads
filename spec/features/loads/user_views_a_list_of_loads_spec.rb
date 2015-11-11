require 'rails_helper'

feature 'user views a list of loads' do
  context 'when there are loads' do
    given!(:loads) { create_list(:load, 3) }
    given!(:dispatched_load) do
      create(:load, driver_name: 'Bob', status: :shipped)
    end

    before { visit loads_path }

    scenario 'the loads are shown' do
      expect(page).to have_content(I18n.t('loads.index.title'))
      expect_load_row loads[0]
      expect_load_row loads[1]
      expect_load_row loads[2]
    end

    context 'when searching for loads' do
      scenario 'allows search by driver' do
        select dispatched_load.driver_name, from: 'q_driver_name_eq'

        click_button('Search')

        expect(page).to_not have_content(loads[0].customer_name)
        expect(page).to have_content(dispatched_load.customer_name)
      end
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
  [
    :customer_name,
    :customer_location,
    :origin_location,
    :product_description,
    :requested_date,
    :status
  ].each { |attribute| expect(page).to have_content(load.send(attribute)) }
end
