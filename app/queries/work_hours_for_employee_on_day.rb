class WorkHoursForEmployeeOnDay
  def self.result(employee, day)
    result = 0
    employee.records.where(type: 'Worktime').where('date_from >= ? and date_to <= ?', day, day + 1.day).each do |record|
      result += record.date_to - record.date_from
    end
    result / (60*60)
  end
end