class RecordsController < ApplicationController

  before_action :set_record, only: [:boss_approve, :boss_disapprove, :bookkeeper_approve, :edit, :update, :destroy]

  def index
  end

  def create
    @record = Record.new record_params
    @record.user = current_user
    if @record.save
      Comment.create message: params[:comment], record: @record, user: current_user
      redirect_to pending_records_path
    else
      render 'new'
    end
  end

  def new
    @record = Record.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def pending
    @records = PendingRecordsForBoss.result current_user
  end

  def requested
    return unless current_user.present?
    #TODO: should display only relevant records (this month?)
    @records = current_user.records
  end

  def bookkeeping
    #TODO: should display only relevant records (last month)
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
    if params.has_key? :record
      return params.require(:record).permit(:type, :date_from, :date_to, :emails)
    end
    if params.has_key? :vacation
      return params.require(:vacation).permit(:type, :date_from, :date_to, :emails)
    end
    if params.has_key? :day_off
      return params.require(:day_off).permit(:type, :date_from, :date_to, :emails)
    end
    if params.has_key? :sickness
      return params.require(:sickness).permit(:type, :date_from, :date_to, :emails)
    end
  end

  def set_record
    @record = Record.find params[:id]
  end
end
