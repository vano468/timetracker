class OverlappingRecords
  def self.result(user, date_from, date_to, record = nil)
    r1 = user.records.where.not(id: record).where('date_from <= ? and date_to >= ?', date_from, date_from).take
    r2 = user.records.where.not(id: record).where('date_from <= ? and date_to >= ?', date_to, date_to).take
    r3 = user.records.where.not(id: record).where('date_from >= ? and date_to <= ?', date_from, date_to).take
    return r1, r2, r3
  end
end