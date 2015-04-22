class RecordsController < ApplicationController

  authorize_resource

  before_action :set_record, only: [:show, :boss_approve, :boss_disapprove, :bookkeeper_approve, :edit, :update, :destroy]

  def index
  end

  def create
    @record = Record.new record_params
    @record.user = current_user
    if @record.save
      Comment.create message: params[:comment], record: @record, user: current_user
      redirect_to requested_records_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
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
    # TODO: should display only relevant records (this month?)
    @records = current_user.records.where.not(type: 'Worktime')
  end

  def bookkeeping
    # TODO: should display only relevant records (last month)
    @records = Record.all.where(bookkeeper_approved: nil, type: %w[Vacation Sickness])
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

  def record_params
    [:record, :vacation, :day_off, :sickness].each do |type|
      return params.require(type).permit(:type, :date_from, :date_to, :emails) if params.has_key? type
    end
  end

  def set_record
    @record = Record.find params[:id]
  end
end
