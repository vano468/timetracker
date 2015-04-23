module DepartmentsHelper
  def departments_hierarchy
    Department.hierarchy_tree
  end
end