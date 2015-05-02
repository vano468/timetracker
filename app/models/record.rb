require 'valid_email/email_validator'

class Record < ActiveRecord::Base
  attr_accessor :comment

  belongs_to :user
  has_many :comments, dependent: :destroy

  validate :date_from_lesser_than_date_to, unless: -> (record) { record.is_a? Worktime }
  validate :dates_cannot_be_in_the_past, :emails_should_be_valid, unless: -> (record) { record.is_a? Worktime }

  after_save :send_notifications

private

  def send_notifications
    puts "Let's send some notifications for those emails: #{emails}"
  end

  def date_from_lesser_than_date_to
    if date_from > date_to
      errors.add :date_to, 'can\'t be before date_from'
    end
  end

  def dates_cannot_be_in_the_past
    if date_from.day < Date.today.day
      errors.add :date_from, 'can\'t be in the past'
    end
    if date_to.day < Date.today.day
      errors.add :date_to, 'can\'t be in the past'
    end
  end

  def emails_should_be_valid
    emails_array = emails.split
    emails_array.each_with_index do |email, index|
      errors.add("email_#{index}", "#{email} is invalid") unless ValidateEmail.valid? email
    end
  end
end
