class Admin::DepartmentsController < ApplicationController
  include AjaxHelper

  def new
    @department = Department.new
    respond_to do |format|
      format.js
    end
  end

  def create
    Rails.application.routes.recognize_path(request.referrer)[:id]
    respond_to do |format|
      format.js { render ajax_redirect_to(departments_path) }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
