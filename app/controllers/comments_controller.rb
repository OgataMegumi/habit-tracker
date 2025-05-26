class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comments_path, notice: "コメントを投稿しました。"
    else
      render :new
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
