class Worktime < Record
  attr_accessor :time_from, :time_to, :day

  before_save :build_record

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
end