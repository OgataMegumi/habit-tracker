require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }

  describe 'PATCH /user/toggle_completed_tasks' do
    before do
      login_as(user, scope: :user)
    end

    context 'show_completed_tasksパラメータが正しく与えられた場合' do
      it 'trueを保存し、200 OKを返す' do
        patch toggle_completed_tasks_user_path, params: { show_completed_tasks: 'true' }

        expect(response).to have_http_status(:ok)
        expect(user.reload.show_completed_tasks).to be true
      end

      it 'falseを保存し、200 OKを返す' do
        patch toggle_completed_tasks_user_path, params: { show_completed_tasks: 'false' }

        expect(response).to have_http_status(:ok)
        expect(user.reload.show_completed_tasks).to be false
      end
    end

    context 'show_completed_tasksパラメータが存在しない場合' do
      it '400 Bad Requestを返す' do
        patch toggle_completed_tasks_user_path

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'show_completed_tasksアクションの実行時にユーザーの更新に失敗したとき' do
      before do
        allow_any_instance_of(User).to receive(:update).and_return(false)
      end

      it '422 Unprocessable Entityを返す' do
        patch toggle_completed_tasks_user_path, params: { show_completed_tasks: 'true' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
