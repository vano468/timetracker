class Worktime < Record
  attr_accessor :time_from, :time_to, :day

  has_one :comment, foreign_key: 'record_id', dependent: :destroy

  scope :user, -> (user) { where user: user }

  def self.for_day(day)
    from = DateTime.parse day
    where 'date_from >= ? and date_to <= ?', from, from + 1.day
  end
end