class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.parents.includes(:user, :replies).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @comment = Comment.build_by_user(current_user, comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by_user(current_user, params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
