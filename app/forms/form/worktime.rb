module Form
  class Worktime < Reform::Form
    include Reform::Form::ActiveModel
    include ModelReflections
    include Composition

    def initialize(options)
      @user = options[:user]
      super options
    end

    properties :day, :time_from, :time_to, :date_from, :date_to, on: :worktime
    properties :message, on: :comment
    model :worktime

    validates_time :time_from, :time_to
    validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
    validates      :time_from, :time_to, format: { without: /\A24:00\z/, message: 'midnight is not allowed' }
    validate       :time_from_lesser_than_time_to, :records_should_not_overlap

    def time_from=(v)
      self.date_from = DateTime.parse "#{day} #{v}"
      super v
    end

    def time_to=(v)
      self.date_to = DateTime.parse "#{day} #{v}"
      super v
    end

  private

    def time_from_lesser_than_time_to
      if time_from >= time_to
        errors.add :time_to, 'can\'t be before or equal From Time'
      end
    end

    def records_should_not_overlap
      r1, r2, r3 = OverlappingRecords.result @user, date_from, date_to, model[:worktime]
      errors.add :time_from, 'overlaps other record' if r1.present? or r3.present?
      errors.add :time_to, 'overlaps other record'   if r2.present? or r3.present?
    end
  end
end