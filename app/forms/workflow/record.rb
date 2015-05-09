module Workflow
  class Record
    attr_accessor :user, :record, :params

    def initialize(user, record, params)
      @user   = user
      @record = record
      @params = params
    end

    def process
      if record.new_record?
        Service::ManageRecord.new(user, params).create
      else
        Service::ManageRecord.new(user, params).update record.id
      end
    end
  end
end