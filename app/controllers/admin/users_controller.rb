class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.ordered
  end

  def create
    @user = User.new user_params
    @user.password = Devise.friendly_token[0, 8]
    if @user.save
      redirect_to @user.department.present? ? department_path(@user.department) : departments_path
    else
      render 'new'
    end
  end

  def new
    department_id = Rails.application.routes.recognize_path(request.referrer)[:id]
    @user = User.new department_id: department_id
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    redirect_path = (@user.department.present? ? @user.department : departments_path)
    @user.destroy
    redirect_to redirect_path
  end

  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :department_id, :first_name, :middle_name, :last_name)
  end
end
