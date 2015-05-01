module Workflow
  class Worktime
    attr_reader :form, :params, :user

    def initialize( user, form, params)
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

          end
          yield worktime if block_given?
        end
      end
    end
  end
end