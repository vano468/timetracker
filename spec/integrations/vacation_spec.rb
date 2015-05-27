require 'rails_helper'
require 'capybara/rails'

RSpec.describe Worktime, type: :view do
  include Warden::Test::Helpers

  DATE_FORMAT = '%d/%m/%Y'
  WORD_DATE_FORMAT = '%B %d, %Y'

  describe 'vacation form page', type: :feature do
    let(:record) do
      {
        from: Time.now,
        to: Time.now + 24 * 60 * 60,
        emails: 'test1@gmail.com test2@email.com',
        comment: 'Some test comment'
      }
    end

    let(:_record) do
      {
        from: Time.now + 24 * 60 * 60,
        to: Time.now,
        emails: 'test1@gmail.com test2@email.com',
        comment: 'Some test comment'
      }
    end

    before do
      Capybara.default_driver = :selenium
      FactoryGirl.reload
      login_as(FactoryGirl.create(:user), scope: :user)
    end 

    it 'adds new vacation record' do
      visit '/records/new/vacation'
      fill_and_submit_form(form_id, record)
      check_page(page, record)
    end

    it 'can\'t add wrong vacation record' do
      visit '/records/new/vacation'
      fill_and_submit_form(form_id, _record)
      expect(page).to have_css(form_id)
    end

  end

  def fill_and_submit_form(id, record)
    within id do
      fill_in('vacation_date_from', with: record[:from].strftime(DATE_FORMAT))
      fill_in('vacation_date_to', with: record[:to].strftime(DATE_FORMAT))
      fill_in('vacation_emails', with: record[:emails])
      fill_in('vacation_comment', with: record[:comment])
      find('input.btn.btn-primary').click
    end
  end

  def check_page(page, record)
    expect(page).not_to have_css(form_id)
    expect(page).to have_content(record[:from].strftime(WORD_DATE_FORMAT))
    expect(page).to have_content(record[:to].strftime(WORD_DATE_FORMAT))
  end

  def form_id
    '#new_vacation'
  end
end
