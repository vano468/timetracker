module Service
  class CreateRecord
    attr_reader :record_params

    def initialize(user, record_params)
      @record_params = record_params.merge user: user
    end

    def create
      record = Record.new record_params
      if record.date_to
        record.date_to += 23.hours
        record.date_to += 59.minutes
      end
      if record.save
        Comment.create message: record_params[:comment], record: record, user: record_params[:user]
      end
      record
    end
  end
end