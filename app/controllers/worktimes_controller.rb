class WorktimesController < ApplicationController
  include CalendarHelper

  authorize_resource
  before_action :set_exist_worktime, only: [:edit, :update, :destroy]
  before_action :create_new_form,    only: [:index, :show, :create]
  before_action :create_edit_form,   only: [:edit, :update]

  def index
    set_worktimes date_today
  end

  def show
    set_worktimes params[:id]
    respond_to do |format|
      format.html { redirect_to worktimes_path }
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to worktimes_path }
      format.js
    end
  end

  def create
    handle_update_or_create
  end

  def update
    handle_update_or_create
  end

  def destroy
    @worktime.destroy
  end

private

  def handle_update_or_create
    workflow = Workflow::Worktime.new current_user, @form, worktime_params

    respond_to do |format|
      if workflow.process
        set_worktimes worktime_params[:day]
        create_new_form
        format.js
      else
        @worktime = @form.model[:worktime]
        format.js { render json: { action: workflow.action, content: render_to_string(partial: 'form') },
                           status: :unprocessable_entity }
      end
    end
  end

  def set_worktimes(day = nil)
    day = WorktimeDecorator.decorate(@worktime).only_day unless @worktime.nil?
    @worktimes = Worktime.user(current_user).for_day(day).decorate
    set_new_worktime day
  end

  def set_new_worktime(day)
    @worktime  = Worktime.new(day: day).decorate
  end

  def set_exist_worktime
    @worktime = Worktime.find(params[:id]).decorate
  end

  def create_new_form
    @form = Form::Worktime.new worktime: Worktime.new.decorate, comment: Comment.new, user: current_user
  end

  def create_edit_form
    @form = Form::Worktime.new worktime: @worktime, comment: @worktime.comment || Comment.new, user: current_user
  end

  def worktime_params
    params.require(:worktime).permit(:day, :time_from, :time_to, :message)
  end
end