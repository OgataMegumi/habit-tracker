require 'rails_helper'

RSpec.describe TasksController, type: :request do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET #index' do
    it '200 OKでレスポンスを返す' do
      get tasks_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(task.title)
    end
  end

  describe 'PATCH #toggle_today' do
    it 'タスクの本日の状態を切り替えてJSONを返す' do
      post toggle_today_task_path(task), xhr: true

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json['success']).to eq(true)
      expect(json).to have_key('executed')
      expect(json).to have_key('completion_rate')
    end
  end

  describe 'GET #new' do
    it '200 OKを返す' do
      get new_task_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('form')
    end
  end

  describe 'GET #edit_modal' do
    it '200 OKを返し、部分テンプレートが含まれる' do
      get edit_modal_task_path(task), xhr: true
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('form')
    end
  end

  describe 'POST #create' do
    context '有効なパラメータの場合' do
      it 'タスクを作成し、リダイレクトする' do
        expect {
          post tasks_path, params: { task: attributes_for(:task) }
        }.to change(Task, :count).by(1)

        expect(response).to redirect_to(tasks_path)
      end
    end

    context '無効なパラメータの場合' do
      it 'タスク作成に失敗し、jsを返す' do
        post tasks_path,
          params: { task: { title: '' } },
          headers: { 'ACCEPT' => 'application/javascript' }

        expect(response).to have_http_status(:ok)
        expect(Task.count).to eq(1)
      end
    end
  end

  describe 'PATCH #update' do
    context '有効なパラメータの場合' do
      it 'タスクを更新し、js形式でレスポンスを返す' do
        patch task_path(task),
          params: { task: { title: 'Updated Title' } },
          headers: { 'ACCEPT' => 'text/javascript' }

        expect(response).to have_http_status(:ok)
        expect(task.reload.title).to eq('Updated Title')
        expect(response.media_type).to eq('text/javascript')
      end

      it 'HTML形式でリダイレクトする' do
        patch task_path(task),
          params: { task: { title: 'Updated Title 2' } },
          headers: { 'ACCEPT' => 'text/html' }

        expect(response).to redirect_to(tasks_path)
        expect(task.reload.title).to eq('Updated Title 2')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'タスクを削除してタスク一覧にリダイレクトする' do
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_path)
    end
  end
end
