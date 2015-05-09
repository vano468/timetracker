class RecordsController < ApplicationController
  authorize_resource
  before_action :set_record, only: [:show, :boss_approve, :boss_disapprove, :bookkeeper_approve, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def edit
    session[:record_page] = request.env['HTTP_REFERER']
  end

  def create
    @record = Workflow::Record.new(current_user, Record.new, record_params).process
    handle_update_or_create requested_records_path
  end

  def update
    @record = Workflow::Record.new(current_user, @record, record_params).process
    handle_update_or_create session[:record_page]
  end

  def destroy
    @record.destroy
    redirect_to :back
  end

  def vacation
    @record = Vacation.new
    render 'new'
  end

  def sickness
    @record = Sickness.new
    render 'new'
  end

  def day_off
    @record = DayOff.new
    render 'new'
  end

  def pending
    @records = PendingRecordsForBoss.result current_user
  end

  def requested
    # todo: should display only relevant records (this month?)
    @records = current_user.records.where.not(type: 'Worktime')
  end

  def bookkeeping
    # todo: should display only relevant records (last month)
    @records = Record.all.where(bookkeeper_approved: nil, type: %w([Vacation Sickness]))
  end

  def boss_approve
    @record.update_attribute :boss_approved, true
    redirect_to :back
  end

  def boss_disapprove
    @record.update_attribute :boss_approved, false
    redirect_to :back
  end

  def bookkeeper_approve
    @record.update_attribute :bookkeeper_approved, true
    redirect_to :back
  end

private

  def handle_update_or_create(redirect_path)
    if @record.errors.empty?
      redirect_to redirect_path
    else
      render 'new'
    end
  end

  def record_params
    [:record, :vacation, :day_off, :sickness].each do |type|
      return params.require(type).permit(:type, :date_from, :date_to, :emails, :comment) if params.has_key? type
    end
  end

  def set_record
    @record = Record.find params[:id]
  end
end
