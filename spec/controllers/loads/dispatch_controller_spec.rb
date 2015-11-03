require 'rails_helper'

RSpec.describe Loads::DispatchController, type: :controller do
  before do
    allow(Load)
      .to receive(:find)
      .with(load.id.to_s)
      .and_return(load)
  end
  let(:load) { build_stubbed(:load) }

  describe 'GET edit' do
    before { get :edit, load_id: load.id }

    it_behaves_like 'a successful request'
    it_behaves_like 'an edit'
  end

  describe 'PATCH update' do
    before do
      allow(DispatchLoad).to receive(:new) { service }

      patch :update, load_id: load.id, entry: params
    end
    let(:dispatch?) { fail 'dispatch? has not been set' }
    let(:service) do
      dispatch_service = spy
      allow(dispatch_service).to receive(:dispatch) { dispatch? }
      allow(dispatch_service).to receive(:load) { load }
      dispatch_service
    end

    context 'when the details are not valid' do
      let(:params) { {} }

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit'
    end

    context 'when the dispatch is successful' do
      let(:dispatch?) { true }
      let(:params) do
        { carrier_name: Faker::Company.name, driver_name: Faker::Name.name }
      end

      it { is_expected.to redirect_to(load_path(controller.load)) }
      it do
        is_expected
          .to set_flash[:notice].to(I18n.t('loads.dispatch.update.success'))
      end
    end

    context 'when the dispatch is not successful' do
      let(:dispatch?) { false }
      let(:params) do
        { carrier_name: Faker::Company.name, driver_name: Faker::Name.name }
      end

      it_behaves_like 'a successful request'
      it_behaves_like 'an edit'
      it do
        is_expected
          .to set_flash[:alert].to(I18n.t('loads.dispatch.update.failure'))
      end
    end
  end
end
