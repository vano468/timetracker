require 'rails_helper'

RSpec.describe WorktimesController, type: :controller do
  include Devise::TestHelpers

  describe 'index action' do
    context 'when is guest' do
      it 'redirects to root' do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'when is user' do
      before { sign_in FactoryGirl.create :user }
      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq 200
      end
    end
  end
end