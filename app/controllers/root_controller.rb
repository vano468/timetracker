class RootController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.has_role? :admin
      redirect_to departments_path
    else
      redirect_to worktimes_path
    end
  end
end