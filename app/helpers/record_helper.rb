module RecordHelper
  def record_status(record)
    case record.boss_approved
      when true
        return 'Approved'
      when false
        return 'Disapproved'
      when nil
        return 'Pending'
    end
  end
end