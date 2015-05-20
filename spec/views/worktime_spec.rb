require 'rails_helper'
require 'capybara/rails'

RSpec.describe Worktime, type: :view do
  include Warden::Test::Helpers

  describe "the user's landing page", type: :feature do
   let(:record) do
      {
        from: '10:00',
        to: '19:00',
        message: 'Test record message'
      }
    end
    let(:error_record) do
      {
        from: '19:00',
        to: '10:00',
        message: 'Test record message'
      }
    end

    before do
      login_as(FactoryGirl.create(:user), scope: :user)
      Capybara.default_driver = :selenium
    end

    it 'can add new record' do
      sleep(10)
      open_and_fill_record_form(record)
      expect(page).to(have_content(record[:from]))
      expect(page).to(have_content(record[:to]))
      expect(page).to(have_content(record[:message]))
    end

    it 'can\'t add incorrect record' do
      open_and_fill_record_form(error_record)
      expect(page).to have_selector('#new-record-modal', visible: true)
    end
  end

  def open_and_fill_record_form(record)
    visit '/worktime'
      page.find('#new-record', text: 'Add record').click
      within '#new-record-modal' do
        fill_in('worktime_time_from', with: record[:from])
        fill_in('worktime_time_to', with: record[:to])
        fill_in('worktime_message', with: record[:message])
        find('#submit').click
      end
  end
end
