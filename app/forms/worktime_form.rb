class WorktimeForm < Reform::Form
  include Reform::Form::ActiveRecord
  include Reform::Form::ActiveModel::FormBuilderMethods
  include ModelReflections
  include Composition

  properties :time_from, :time_to, :day, on: :worktime
  property :message, on: :comment

  validates_time :time_from, :time_to
  validates      :time_from, :time_to, format: { with: /\A[0-2][0-9]:[0-5][0-9]\z/, message: 'should be in hh:mm format' }
  validate       :time_from_lesser_than_time_to

  model :worktime

  def time_from_lesser_than_time_to
    if time_from >= time_to
      errors.add :time_to, 'can\'t be before or equal From Time'
    end
  end
end