class Worktime < Record
  include CalendarHelper

  attr_accessor :time_from, :time_to, :day

  validates :time_from, length: { is: 5 }
  validates :time_to,   length: { is: 5 }

  before_save :build_record
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
end