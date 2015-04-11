class WorktimesController < ApplicationController
  include CalendarHelper

  before_action :set_worktime, only: [:edit, :update, :destroy]

  def index
    set_worktimes today_format
  end

  def show
    set_worktimes params[:id]
    respond_to do |format|
      format.html { redirect_to worktimes_path }
      format.js
    end
  end

  def create
    @worktime = Worktime.new worktime_params
    @worktime.user = current_user

    respond_to do |format|
      if @worktime.save
        set_worktimes only_day @worktime.date_from
        format.js
      else
        format.js { render json: @worktime.errors }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to worktimes_path }
      format.js
    end
  end

  def update
    respond_to do |format|
      if @worktime.update worktime_params
        set_worktimes only_day @worktime.date_from
        format.js
      else
        format.js { render json: @worktime.errors }
      end
    end
  end

  def destroy
    @worktime.destroy
  end

private

  def set_worktimes(day)
    @worktimes = Worktime.user(current_user).day day
    @worktime  = Worktime.new
    @worktime.day = day
  end

  def set_worktime
    @worktime = Worktime.find params[:id]
  end

  def worktime_params
    params.require(:worktime).permit :day, :time_from, :time_to
  end
end