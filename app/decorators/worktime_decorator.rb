class WorktimeDecorator < Draper::Decorator
  delegate_all

  def day
    date = object.day
    date = only_day unless date
    date
  end

  def day_title
    date = day
    date = DateTime.parse date unless date.instance_of? DateTime
    "#{Date::MONTHNAMES[date.month]} #{date.day}"
  end

  def form_title
    if object.new_record?
      'Create WorkTime Record'
    else
      'Edit WorkTime Record'
    end
  end

  def submit_text
    if object.new_record?
      'Create'
    else
      'Save'
    end
  end

  def only_day
    day_format object.date_from
  end

  def time_from
    time_format object.date_from
  end

  def time_to
    time_format object.date_to
  end

private

  def day_format(datetime)
    datetime.strftime '%Y-%m-%d' unless datetime.nil?
  end

  def time_format(datetime)
    datetime.strftime '%H:%M' unless datetime.nil?
  end
end