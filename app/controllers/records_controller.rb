class RecordsController < ApplicationController

  def index
  end

  def create
    #TODO: add record_params here
    @record = Record.new
    @record.user = current_user
    #TODO: type must be read from params
    @record.type = 'Vacation'
    if @record.save
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
    return unless current_user.present?
    department = current_user.boss_of
    return unless department.present?
    @records = []
    department.employees.each do |e|
      records = e.records.where(type: 'Vacation', boss_approved: nil)
      records.each do |r|
        @records << r
      end
    end
  end

  def requested
    return unless current_user.present?
    #TODO: should display only relevant records (this month?)
    @records = current_user.records
  end


  def boss_approve
    @record = Record.find params[:id]
    @record.update_attribute :boss_approved, true
    redirect_to :back
  end

  def boss_disapprove
    @record = Record.find params[:id]
    @record.update_attribute :boss_approved, false
    redirect_to :back
  end

private

  def record_params
    params
  end
end
