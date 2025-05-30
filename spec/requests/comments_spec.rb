require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let!(:comment) { create(:comment, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /comments" do
    it "コメント一覧ページが表示されること" do
      get comments_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /comments/new" do
    it "新規コメント投稿フォームが表示されること" do
      get new_comment_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /comments" do
    context "正しいコメントが送信されたとき" do
      it "保存され、ページ遷移すること" do
        expect {
          post comments_path, params: { comment: { content: "テストコメント" } }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to(new_comment_path)
      end
    end

    context "空のコメントが送信されたとき" do
      it "空のコメントは保存されず、フォームが再表示されること" do
        expect {
          post comments_path, params: { comment: { content: "" } }
        }.not_to change(Comment, :count)

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("コメント投稿")
      end
    end
  end

  describe "DELETE /comments/:id" do
    it "コメントを削除したら、正しく削除されて一覧ページに戻ること" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)

      expect(response).to redirect_to(comments_path)
    end
  end
end
