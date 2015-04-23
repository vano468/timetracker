class Admin::DepartmentsController < ApplicationController
  include AjaxHelper

  def new
    @department = Department.new
  end

  def create
    Rails.application.routes.recognize_path(request.referrer)[:id]
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
