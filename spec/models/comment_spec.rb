require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }

  describe 'アソシエーション' do
    context ':user アソシエーション' do
      it 'コメントがユーザーに属していること（belongs_to）' do
        assoc = Comment.reflect_on_association(:user)
        expect(assoc.macro).to eq(:belongs_to)
      end
    end

    context ':parent アソシエーション' do
      it '子コメントが親コメントを参照できること（belongs_to）' do
        assoc = Comment.reflect_on_association(:parent)
        expect(assoc.macro).to eq(:belongs_to)
      end

      it '親コメントの参照先が Comment クラスであること' do
        assoc = Comment.reflect_on_association(:parent)
        expect(assoc.options[:class_name]).to eq('Comment')
      end

      it '親コメントが存在しなくてもコメントを作成できること' do
        assoc = Comment.reflect_on_association(:parent)
        expect(assoc.options[:optional]).to be true
      end
    end

    context ':replies アソシエーション' do
      it '親コメントが複数の返信コメントを持てること' do
        assoc = Comment.reflect_on_association(:replies)
        expect(assoc.macro).to eq(:has_many)
      end

      it '返信コメントのクラスが Comment であること' do
        assoc = Comment.reflect_on_association(:replies)
        expect(assoc.options[:class_name]).to eq('Comment')
      end

      it '返信コメントの外部キーが parent_id であること' do
        assoc = Comment.reflect_on_association(:replies)
        expect(assoc.options[:foreign_key]).to eq('parent_id')
      end

      it '親コメントが削除されると、返信コメントも削除されること' do
        assoc = Comment.reflect_on_association(:replies)
        expect(assoc.options[:dependent]).to eq(:destroy)
      end
    end
  end

  describe 'バリデーション' do
    it 'content がある場合は有効であること' do
      comment = Comment.new(content: 'これはコメントです', user: FactoryBot.create(:user))
      expect(comment).to be_valid
    end

    it 'content が空の場合は無効であること' do
      comment = Comment.new(content: '', user: FactoryBot.create(:user))
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("を入力してね")
    end
  end

  describe 'スコープ' do
    describe '.root_comments' do
      it '親を持たないコメントを新しい順に返すこと' do
        parent_comment = create(:comment, user: user, created_at: 1.day.ago)
        newer_parent = create(:comment, user: user, created_at: Time.current)
        create(:comment, user: user, parent: parent_comment) # reply

        results = Comment.root_comments
        expect(results).to eq([ newer_parent, parent_comment ])
      end
    end

    describe '.parents' do
      it '親を持たないコメントのみを返すこと' do
        parent = create(:comment, user: user)
        reply = create(:comment, user: user, parent: parent)

        expect(Comment.parents).to include(parent)
        expect(Comment.parents).not_to include(reply)
      end
    end
  end

  describe '.build_by_user' do
    it '指定したユーザーに関連づいたコメントを作成できること' do
      params = { content: "テストコメント" }
      comment = Comment.build_by_user(user, params)

      expect(comment.user).to eq(user)
      expect(comment.content).to eq("テストコメント")
    end
  end

  describe '.find_by_user' do
    it '対象ユーザーが所有するコメントを取得できること' do
      comment = create(:comment, user: user)
      found = Comment.find_by_user(user, comment.id)

      expect(found).to eq(comment)
    end

    it '対象ユーザーが所有していないコメントを取得しようとするとエラーになること' do
      other_user = create(:user)
      comment = create(:comment, user: other_user)

      expect {
        Comment.find_by_user(user, comment.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
