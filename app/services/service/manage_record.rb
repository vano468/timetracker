module Service
  class ManageRecord
    attr_reader :record_params

    def initialize(user, record_params)
      @record_params = record_params.merge user: user
    end

    def create
      record = Record.new record_params
      update_date_to record
      Comment.create(message: record_params[:comment], record: record, user: record_params[:user]) if record.save
      record
    end

    def update(record_id)
      record = Record.find record_id
      if record
        record.assign_attributes record_params
        update_date_to record
        record.save
      end
      record
    end

  private

    def update_date_to(record)
      if record.date_to
        record.date_to += 23.hours
        record.date_to += 59.minutes
      end
    end
  end
end