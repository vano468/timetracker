class PendingRecordsForBoss
  def self.result(boss)
    result_records = []
    return unless boss.present?
    department = boss.boss_of
    return unless department.present?
    department.employees.each do |e|
      # We presume that boss is in the same department as his subordinates, so we have to exclude his records
      records = e.records.where(boss_approved: nil).where.not(type: nil, user: boss)
      records.each do |r|
        result_records << r
      end
    end
    result_records
  end
end