class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_show_header

  # Deviseの登録後やログイン後のリダイレクト先を設定
  def after_sign_in_path_for(resource)
    tasks_path # タスク一覧画面にリダイレクト
  end

  def after_sign_up_path_for(resource)
    tasks_path # ユーザー登録後もタスク一覧画面にリダイレクト
  end

  private

  def set_show_header
    # ヘッダーを非表示にするパスを指定
    @show_header = !%w[/users/sign_in /users/sign_up].include?(request.path)
  end
end
