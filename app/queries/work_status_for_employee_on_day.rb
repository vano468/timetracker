class WorkStatusForEmployeeOnDay
  def self.result(employee, day)
    single_day_record = SingleDayRecordsForEmployeeOnDay.result(employee, day).take
    multi_day_record  = MultiDayRecordsForEmployeeOnDay.result(employee, day).take

    return { hours: 0, minutes: 0 }          if single_day_record.nil? and multi_day_record.nil?
    return work_hours_for_day(employee, day) if single_day_record.is_a? Worktime
    return single_day_record.type            if single_day_record.present?
    return multi_day_record.type             if multi_day_record.present?

    # this line should not be reached
    'ERROR'
  end

private

  def self.work_hours_for_day(employee, day)
    result = { hours: 0, minutes: 0 }
    total_seconds = 0
    SingleDayRecordsForEmployeeOnDay.result(employee, day).each do |record|
      total_seconds += record.date_to - record.date_from
    end
    result[:hours] = total_seconds.div(60 * 60)
    result[:minutes] = total_seconds.modulo(60 * 60).div(60)
    result
  end
end