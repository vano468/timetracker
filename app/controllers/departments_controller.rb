class DepartmentsController < ApplicationController
  before_action :set_department,  only: :show
  before_action :set_breadcrumbs, only: :show

  def index
    @departments = Department.top_level
    @users = User.without_department
  end

  def show
    @departments = @department.children
    @users = @department.employees
  end

  def stats
  end

private

  def set_department
    @department = Department.find params[:id]
  end

  def set_breadcrumbs
    add_breadcrumb 'Root', departments_path
    @department.hierarchy.each do |dep|
      add_breadcrumb dep.title, department_path(dep)
    end
  end
end