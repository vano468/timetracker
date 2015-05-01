class WorktimeForm < Reform::Form
  include Reform::Form::ActiveRecord
  include Reform::Form::ActiveModel::FormBuilderMethods
  include ModelReflections
  include Composition

  properties :time_from, :time_to, :day, on: :worktime
  property :message, on: :comment

  model :worktime
end