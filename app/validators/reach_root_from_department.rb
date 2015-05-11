class ReachRootFromDepartment < ActiveModel::Validator
  MAX_HIERARCHY_DEPTH = 10

  def validate(department)
    department.errors.add(:parent_id, 'should be reachable from root') unless reach_root(department)
  end

private

  def reach_root(department)
    @traversed = []
    reach_one_level_up(department, 0)
  end

  def reach_one_level_up(department, depth)
    return false if @traversed.include? department.id
    return true  if department.parent.nil?
    @traversed << department.id
    return false if depth > MAX_HIERARCHY_DEPTH
    reach_one_level_up(department.parent, depth + 1)
  end
end
