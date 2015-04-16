class Worktime < Record
  include CalendarHelper

  attr_accessor :time_from, :time_to, :day

  validates_time :time_from
  validates_time :time_to

  before_validation :build_record
  after_find  :update_attrs

  scope :user, -> (user) { where user: user }

  def self.day(day)
    from = DateTime.parse day
    to   = from + 1.day
    where 'date_from >= ? and date_to <= ?', from, to
  end

private

  def build_record
    self.date_from = DateTime.parse "#{day} #{time_from}"
    self.date_to   = DateTime.parse "#{day} #{time_to}"
  end

  def update_attrs
    self.time_from = only_time self.date_from
    self.time_to   = only_time self.date_to
    self.day = only_day self.date_from
  end

  def date_from_lesser_than_date_to
    if date_from >= date_to
      errors.add :time_to, 'can\'t be before or equal date_from'
    end
  end
end