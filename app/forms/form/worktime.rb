module Form
  class Worktime < Reform::Form
    include Reform::Form::ActiveModel
    include ModelReflections
    include Composition

    properties :day, :time_from, :time_to, on: :worktime
    properties :message, on: :comment
    properties :id, on: :user

    model :worktime

    validates_time :time_from, :time_to
    validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
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
      r1 = Record.where(user_id: id).where('date_from < ? and date_to > ?', date_from, date_from).take
      r2 = Record.where(user_id: id).where('date_from < ? and date_to > ?', date_to, date_to).take
      r3 = Record.where(user_id: id).where('date_from > ? and date_to < ?', date_from, date_to).take
      if r1.present? or r3.present?
        errors.add(:time_from, 'overlaps other record')
      end
      if r2.present? or r3.present?
        errors.add(:time_to, 'overlaps other record')
      end
    end
  end
end