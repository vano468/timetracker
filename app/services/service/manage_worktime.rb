module Service
  class ManageWorktime
    attr_reader :worktime_params, :comment_params

    def initialize(user, worktime_params, comment_params)
      @worktime_params = worktime_params.merge user: user
      @comment_params  = comment_params.merge  user: user
    end

    def create
      worktime = Worktime.new worktime_params
      ActiveRecord::Base.transaction do
        worktime.save!
        create_comment_for worktime
      end
      worktime.decorate
    end

    def update(worktime_id, comment_id)
      ActiveRecord::Base.transaction do
        worktime = Worktime.find worktime_id
        comment  = Comment.find_by id: comment_id
        worktime.update! worktime_params
        if comment
          update_comment comment
        else
          create_comment_for worktime
        end
        worktime.decorate
      end
    end

  private

    def create_comment_for(worktime)
      comment = worktime.build_comment comment_params
      comment.save! unless comment.message.empty?
    end

    def update_comment(comment)
      if comment_params[:message].empty?
        comment.destroy
      else
        comment.update! comment_params
      end
    end
  end
end