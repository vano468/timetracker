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
    set_form
    respond_to do |format|
      if @form.validate params[:worktime]
        @form.save
        set_worktimes @form.model.day
        format.js
      else
        format.js { render json: @form.errors }
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
    set_form @worktime
  end

  def set_worktime
    @worktime = Worktime.find(params[:id]).decorate
    set_form @worktime
  end

  def set_form(worktime = nil, comment = nil)
    worktime = Worktime.new user: current_user if worktime.nil?
    comment  = Comment.new  user: current_user if comment.nil?
    @form = WorktimeForm.new worktime: worktime, comment: comment
  end

  def worktime_params
    params.require(:worktime).permit(:day, :time_from, :time_to, :comment)
  end
end