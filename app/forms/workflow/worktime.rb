module Workflow
  class Worktime
    attr_reader :form, :params, :user

    def initialize(user, form, params)
      @user   = user
      @form   = form
      @params = params
    end

    def process
      if form.validate params
        form.save do |data|
          if form.model[:worktime].new_record?
            worktime = ::Service::ManageWorktime.new(user, data[:worktime], data[:comment]).create
          else
            worktime = ::Service::ManageWorktime.new(user, data[:worktime], data[:comment]).update form.model[:worktime].id, form.model[:comment].id
          end
          yield worktime if block_given?
        end
        true
      else
        false
      end
    end

    def new_record?
      form.model[:worktime].new_record?
    end
  end
end