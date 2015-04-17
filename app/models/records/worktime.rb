class Worktime < Record
  attr_accessor :time_from, :time_to, :day

  validates_time :time_from
  validates_time :time_to

  before_validation :build_record

  scope :user, -> (user) { where user: user }

  def self.for_day(day)
    from = DateTime.parse day
    where 'date_from >= ? and date_to <= ?', from, from + 1.day
  end

private

  def build_record
    self.date_from = DateTime.parse "#{day} #{time_from}"
    self.date_to   = DateTime.parse "#{day} #{time_to}"
  end

  def date_from_lesser_than_date_to
    if date_from >= date_to
      errors.add :time_to, 'can\'t be before or equal date_from'
    end
  end
end