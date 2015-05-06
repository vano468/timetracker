class Admin::AdminController < ApplicationController
  before_action :authorize

  private

  def authorize
    redirect_to :back, alert: 'You are not admin' unless current_user.has_role? :admin
  end
end