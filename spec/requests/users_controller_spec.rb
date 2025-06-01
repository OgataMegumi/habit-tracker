require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'PATCH /user/toggle_completed_tasks' do
    context 'show_completed_tasksパラメータが正しく与えられた場合' do
      it 'trueを保存し、200 OKを返す' do
        patch "/users/#{user.id}/toggle_completed_tasks", params: { show_completed_tasks: 'true' }, as: :json

        expect(response).to have_http_status(:ok)
        expect(user.reload.show_completed_tasks).to be true
      end

      it 'falseを保存し、200 OKを返す' do
        patch "/users/#{user.id}/toggle_completed_tasks", params: { show_completed_tasks: 'false' }, as: :json

        expect(response).to have_http_status(:ok)
        expect(user.reload.show_completed_tasks).to be false
      end
    end

    context 'show_completed_tasksパラメータがない場合' do
      it '400 Bad Requestを返す' do
        patch "/users/#{user.id}/toggle_completed_tasks", as: :json

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'show_completed_tasksアクションの実行時にユーザーの更新に失敗したとき' do
      before do
        allow_any_instance_of(User).to receive(:update).and_return(false)
      end

      it '422 Unprocessable Entityを返す' do
        patch "/users/#{user.id}/toggle_completed_tasks", params: { show_completed_tasks: 'true' }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /user/edit" do
    it "ユーザー編集フォームが表示されること" do
      get edit_user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("ユーザー名の変更")
    end
  end

  describe "PATCH /user" do
    it "ユーザー名が更新されること" do
      patch user_path(user), params: { user: { name: "新しいユーザー名" } }
      expect(response).to redirect_to(comments_path)
      follow_redirect!
      expect(user.reload.name).to eq("新しいユーザー名")
    end
  end
end
