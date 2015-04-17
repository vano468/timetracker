class WorktimesController < ApplicationController
  authorize_resource
  before_action :set_worktime, only: [:edit, :update, :destroy]

  def index
    set_worktimes DateTime.now.strftime '%Y-%m-%d'
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
        set_worktimes
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
        set_worktimes
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

  def set_worktimes(day = nil)
    day = WorktimeDecorator.decorate(@worktime).only_day unless @worktime.nil?
    @worktimes = Worktime.user(current_user).for_day(day).decorate
    @worktime  = Worktime.new(day: day).decorate
  end

  def set_worktime
    @worktime = Worktime.find(params[:id]).decorate
  end

  def worktime_params
    params.require(:worktime).permit :day, :time_from, :time_to
  end
end