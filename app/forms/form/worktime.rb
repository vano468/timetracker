module Form
  class Worktime < Reform::Form
    include Reform::Form::ActiveModel
    include ModelReflections
    include Composition

    def initialize(options)
      @user = options[:user]
      super options
    end

    properties :day, :time_from, :time_to, on: :worktime
    properties :message, on: :comment
    model :worktime

    validates_time :time_from, :time_to
    validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
    validates      :time_from, :time_to, format: { without: /\A24:00\z/, message: 'midnight is not allowed' }
    validate       :time_from_lesser_than_time_to, :records_should_not_overlap

  private

    def time_from_lesser_than_time_to
      if time_from >= time_to
        errors.add :time_to, 'can\'t be before or equal From Time'
      end
    end

    def records_should_not_overlap
      date_from = DateTime.parse "#{day} #{time_from}"
      date_to   = DateTime.parse "#{day} #{time_to}"
      overlap_possibilities = OverlappingRecords.result(@user, date_from, date_to)
      if overlap_possibilities[0].present? or overlap_possibilities[2].present?
        errors.add(:time_from, 'overlaps other record')
      end
      if overlap_possibilities[1].present? or overlap_possibilities[3].present?
        errors.add(:time_to, 'overlaps other record')
      end
    end
  end
end