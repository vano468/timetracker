class Record < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validate :date_from_lesser_than_date_to
  validate :dates_cannot_be_in_the_past unless proc { |record| record.is_a? Worktime}

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
    if date_from.to_day < Date.today.to_day
      errors.add :date_from, 'can\'t be in the past'
    end
    if date_to.to_day < Date.today.to_day
      errors.add :date_to, 'can\'t be in the past'
    end
  end
end
