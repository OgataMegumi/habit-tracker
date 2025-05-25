class ApplicationController < ActionController::Base
  allow_browser versions: :modern unless Rails.env.development?

  before_action :set_show_header

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def after_sign_up_path_for(resource)
    tasks_path
  end

  private

  def set_show_header
    @show_header = !%w[/users/sign_in /users/sign_up].include?(request.path)
  end
end
