class Admin::DepartmentsController < Admin::AdminController
  before_action :set_department, only: [:edit, :update, :destroy]

  def new
    parent_id = Rails.application.routes.recognize_path(request.referrer)[:id]
    @department = Department.new parent_id: parent_id
  end

  def create
    @department = Department.new department_params
    if @department.save
      redirect_to department_path @department
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @department.update department_params
    if @department.save
      redirect_to department_path @department
    else
      render 'edit'
    end
  end

  def destroy
    redirect_path = (@department.parent.present? ? @department.parent : departments_path)
    @department.destroy
    redirect_to redirect_path
  end

private

  def set_department
    @department = Department.find params[:id]
  end

  def department_params
    params.require(:department).permit(:title, :parent_id, :boss_id)
  end
end
