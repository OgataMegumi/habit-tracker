class UsersController < ApplicationController
  before_action :authenticate_user!

  # def show
  # end

  def toggle_completed_tasks
    return head :bad_request if params[:show_completed_tasks].nil?

    # JSONリクエストでは真偽値で送られるが、Railsは文字列として扱うため、Boolean型にキャストする
    value = ActiveModel::Type::Boolean.new.cast(params[:show_completed_tasks])

    if current_user.update(show_completed_tasks: value)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to comments_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
