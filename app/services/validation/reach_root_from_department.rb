module Validation
  class ReachRootFromDepartment
    MAX_HIERARCHY_DEPTH = 10

    def initialize(department)
      @department = department
      @traversed = []
    end

    def reach_root
      reach_one_level_up(@department, 0)
    end

  private

    def reach_one_level_up(department, depth)
      return false if @traversed.include? department.id
      return true  if department.parent.nil?
      @traversed << department.id
      return false if depth > MAX_HIERARCHY_DEPTH
      reach_one_level_up(department.parent, depth + 1)
    end
  end
end