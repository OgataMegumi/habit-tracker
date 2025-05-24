class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def toggle_completed_tasks
    Rails.logger.debug "params[:show_completed_tasks] = #{params[:show_completed_tasks].inspect}"

    return head :bad_request if params[:show_completed_tasks].nil?
  
    value = ActiveModel::Type::Boolean.new.cast(params[:show_completed_tasks])
  
    if current_user.update(show_completed_tasks: value)
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
