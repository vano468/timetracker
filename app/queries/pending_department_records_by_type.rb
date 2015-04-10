class PendingDepartmentRecordsByType
  def self.result(boss, type)
    result_records = []
    return unless boss.present?
    department = boss.boss_of
    return unless department.present?
    department.employees.each do |e|
      records = e.records.where(type: type, boss_approved: nil)
      records.each do |r|
        result_records << r
      end
    end
    result_records
  end
end