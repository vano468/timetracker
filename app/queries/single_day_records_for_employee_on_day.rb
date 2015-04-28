class SingleDayRecordsForEmployeeOnDay
  def self.result(employee, day)
    employee.records.where('date_from >= ? and date_to < ?', day, day + 1.day)
  end
end