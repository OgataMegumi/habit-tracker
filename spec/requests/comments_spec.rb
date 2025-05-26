require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let!(:comment) { create(:comment, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe "コメント一覧ページが表示されること" do
    it "returns http success" do
      get comments_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "新規コメント投稿フォームが表示されること" do
    it "renders the new template" do
      get new_comment_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "正しいコメントが送られたら保存され、ページ遷移すること" do
    context "with valid params" do
      it "creates a new comment and redirects to new_comment_path" do
        expect {
          post comments_path, params: { comment: { content: "テストコメント" } }
        }.to change(Comment, :count).by(1)
  
        expect(response).to redirect_to(new_comment_path)
      end
    end
  
    context "空のコメントは保存されず、フォームが再表示されること" do
      it "does not create a comment and renders :new" do
        expect {
          post comments_path, params: { comment: { content: "" } }
        }.not_to change(Comment, :count)
  
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("コメント投稿")
      end
    end
  end  

  describe "コメントを削除したら、正しく削除されて一覧ページに戻ること" do
    it "deletes the comment and redirects" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)
  
      expect(response).to redirect_to(comments_path)
    end
  end
end
