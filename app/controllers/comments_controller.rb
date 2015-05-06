class CommentsController < ApplicationController
  authorize_resource
  before_action :set_record, only: [:create, :new]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @record.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to session[:comment_page]
    else
      render 'new'
    end
  end

  def new
    session[:comment_page] = request.env['HTTP_REFERER']
    @comment = @record.comments.new
  end

  def edit
    session[:comment_page] = request.env['HTTP_REFERER']
  end

  def update
    @comment.update comment_params
    redirect_to session[:comment_page]
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def set_record
    @record = Record.find params[:record_id]
  end

  def set_comment
    @comment = Comment.find params[:id]
  end

end