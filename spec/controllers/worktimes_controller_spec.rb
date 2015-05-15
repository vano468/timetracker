require 'rails_helper'

RSpec.describe WorktimesController, type: :controller do
  include Devise::TestHelpers
  include CalendarHelper

  let(:worktime) { FactoryGirl.create :worktime }
  let(:user)     { worktime.user }

  describe '#index' do
    context 'when is guest' do
      it 'redirects to root' do
        expect(get :index).to redirect_to root_path
      end
    end

    context 'when is user' do
      before { sign_in user }

      it 'has a 200 status code' do
        expect((get :index).status).to eq 200
      end
    end
  end

  context 'only for signed user' do
    before { sign_in user }

    describe '#show format.js' do
      it 'has a 200 status code' do
        expect((xhr :post, :show, id: date_today).status).to eq 200
      end
    end

    describe '#edit format.js' do
      it 'has a 200 status code' do
        expect((xhr :post, :edit, id: worktime).status).to eq 200
      end
    end

    describe '#create' do
      let(:worktime_params) { FactoryGirl.build :worktime_params }

      it 'has a 200 status code' do
        expect((xhr :post, :create, worktime: worktime_params).status).to eq 200
      end
    end

    describe '#update' do
      let(:worktime_params) { FactoryGirl.build :worktime_params, day: worktime.decorate.day }

      it 'has a 200 status code' do
        expect((xhr :post, :update, id: worktime.id, worktime: worktime_params).status).to eq 200
      end
    end
  end
end