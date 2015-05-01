module Form
  class Worktime < Reform::Form
    include Reform::Form::ActiveModel
    include ModelReflections
    include Composition

    properties :day, :time_from, :time_to, on: :worktime
    properties :message, on: :comment

    model :worktime

    validates_time :time_from, :time_to
    validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
    validate       :time_from_lesser_than_time_to

  private

    def time_from_lesser_than_time_to
      if time_from >= time_to
        errors.add :time_to, 'can\'t be before or equal From Time'
      end
    end
  end
end