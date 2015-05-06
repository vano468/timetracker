require 'valid_email/email_validator'

class Record < ActiveRecord::Base
  attr_accessor :comment

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :date_from, :date_to, date: true, unless: :is_record_worktime?
  validate :dates_cannot_be_in_the_past, :date_from_lesser_than_date_to, :emails_should_be_valid, :records_should_not_overlap, unless: :is_record_worktime?

  after_save :send_notifications

private

  def is_record_worktime?
    self.is_a? Worktime
  end

  def send_notifications
    puts "Let's send some notifications for those emails: #{emails}"
  end

  def dates_cannot_be_in_the_past
    if date_from && date_from < Date.today
      errors.add :date_from, 'can\'t be in the past'
    end
    if date_to && date_to < Date.today
      errors.add :date_to, 'can\'t be in the past'
    end
  end

  def date_from_lesser_than_date_to
    if date_from && date_to && date_from > date_to
      errors.add :date_to, 'can\'t be before date_from'
    end
  end

  def emails_should_be_valid
    emails_array = emails.split
    emails_array.each_with_index do |email, index|
      errors.add(:emails, "#{email} is invalid") unless ValidateEmail.valid? email
    end
  end

  def records_should_not_overlap
    r1 = user.records.where('date_from <= ? and date_to >= ?', date_from, date_from).take
    r2 = user.records.where('date_from <= ? and date_to >= ?', date_to, date_to).take
    r3 = user.records.where('date_from >= ? and date_to <= ?', date_from, date_to).take
    if r1.present? or r3.present?
      errors.add(:date_from, 'overlaps other record')
    end
    if r2.present? or r3.present?
      errors.add(:date_to, 'overlaps other record')
    end
  end
end
