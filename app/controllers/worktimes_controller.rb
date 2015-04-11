class WorktimesController < ApplicationController
  include CalendarHelper

  before_action :set_worktime, only: [:destroy]

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
    if @worktime.save
      redirect_to worktimes_path # todo: replace
    else
      puts 'saving error' # todo: replace
    end
  end

  def update

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