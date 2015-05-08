require 'rails_helper'

RSpec.describe WorktimesController, type: :controller do
  include Devise::TestHelpers
  include CalendarHelper

  let(:user) { FactoryGirl.create :user }

  describe '#index' do
    context 'when is guest' do
      it 'redirects to root' do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'when is user' do
      before { sign_in user }
      it 'has a 200 status code' do
        expect((get :index).status).to eq 200
      end
    end
  end

  describe '#show format.js' do
    before { sign_in user }
    it 'has a 302 status code' do
      expect((get :show, id: date_today).status).to eq 302
    end
  end
end