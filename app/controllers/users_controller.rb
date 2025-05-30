class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def toggle_completed_tasks
    return head :bad_request if params[:show_completed_tasks].nil?

    value = params[:show_completed_tasks] == "true"

    if current_user.update(show_completed_tasks: value)
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
