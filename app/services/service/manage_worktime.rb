module Service
  class ManageWorktime
    attr_accessor :worktime_params, :comment_params

    def initialize(user, worktime_params, comment_params)
      @worktime_params = worktime_params.merge user: user
      @comment_params  = comment_params.merge  user: user
    end

    def create
      worktime = Worktime.new worktime_params
      comment = worktime.build_comment comment_params
      ActiveRecord::Base.transaction do
        worktime.save!
        comment.save! unless comment.message.empty?
      end
      worktime.decorate
    end

    def update(worktime_id, comment_id)

    end
  end
end