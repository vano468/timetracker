class WorkStatusForEmployeeOnDay
  def self.result(employee, day)
    single_day_record = SingleDayRecordsForEmployeeOnDay.result(employee, day).take
    multi_day_record  = MultiDayRecordsForEmployeeOnDay.result(employee, day).take

    return 0                                 if single_day_record.nil? and multi_day_record.nil?
    return work_hours_for_day(employee, day) if single_day_record.is_a? Worktime
    return single_day_record.type            if single_day_record.present?
    return multi_day_record.type             if multi_day_record.present?

    # this line should not be reached
    'ERROR'
  end

private

  def self.work_hours_for_day(employee, day)
    result = 0
    SingleDayRecordsForEmployeeOnDay.result(employee, day).each do |record|
      result += record.date_to - record.date_from
    end
    result / (60 * 60) # datetime stamps are in seconds, method returns hours
  end
end