class Admin::UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_departments, only: [:edit, :new]

  def index
    @users = User.all.ordered
  end

  def create
    @user = User.new user_params
    puts @user.as_json
    if @user.save
      redirect_to admin_users_path
    else
      puts @user.errors.as_json
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  private


  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :department_id)
  end

  def set_departments
    @departments = Department.hierarchy_tree
  end

end
