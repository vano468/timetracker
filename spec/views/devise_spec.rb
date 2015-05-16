require 'rails_helper'
require 'capybara/rails'

RSpec.describe Devise, type: :view do
  include Devise::TestHelpers
  describe 'the sign in process', type: :feature do
    let(:user) { FactoryGirl.create :user }

    it 'should login successfully' do
      visit '/users/sign_in'
      within '#new_user' do
        fill_in('email', with: user.email)
        fill_in('password', with: user.password)
      end
      click_button 'login'
      expect(page).to have_content user.email
    end
  end
end

