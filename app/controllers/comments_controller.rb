class CommentsController < ApplicationController

  before_action :set_record, only: [:create, :new]

  def create
    @comment = @record.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to record_path(@record)
    else
      render 'new'
    end
  end

  def new
    @comment = @record.comments.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def set_record
    @record = Record.find params[:record_id]
  end

end