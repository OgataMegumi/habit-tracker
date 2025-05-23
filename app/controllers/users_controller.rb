# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  # def toggle_completed_tasks
  #   if params[:show_completed_tasks].present?
  #     current_user.update(show_completed_tasks: params[:show_completed_tasks])
  #   end
  #   head :ok
  # end

  def toggle_completed_tasks
    unless params.key?(:show_completed_tasks)
      Rails.logger.warn "⚠️ show_completed_tasks パラメータが存在しません"
    end

    value = ActiveModel::Type::Boolean.new.cast(params[:show_completed_tasks])
    Rails.logger.debug "=== Parsed show_completed_tasks: #{value}"

    current_user.update(show_completed_tasks: value)
    head :ok
  end
end
