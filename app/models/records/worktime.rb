class Worktime < Record
  attr_accessor :time_from, :time_to, :day

  before_save :build_record

  scope :user, -> (user) { where user: user }

  validates_time :time_from, :time_to
  validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
  validate       :time_from_lesser_than_time_to

  def self.for_day(day)
    from = DateTime.parse day
    where 'date_from >= ? and date_to <= ?', from, from + 1.day
  end

private

  def build_record
    self.date_from = DateTime.parse "#{day} #{time_from}"
    self.date_to   = DateTime.parse "#{day} #{time_to}"
  end

  def time_from_lesser_than_time_to
    if time_from >= time_to
      errors.add :time_to, 'can\'t be before or equal From Time'
    end
  end
end