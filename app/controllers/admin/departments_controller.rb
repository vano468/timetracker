class Admin::DepartmentsController < ApplicationController

  def new
    @department = Department.new
    Rails.application.routes.recognize_path(request.referrer)[:id]
    respond_to do |format|
      format.js
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
