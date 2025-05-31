require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    it 'タイトルがなければ無効' do
      task = build(:task, title: nil)
      expect(task).not_to be_valid
    end

    it 'タイトルが15文字を超えると無効' do
      task = build(:task, title: 'あ' * 16)
      expect(task).not_to be_valid
    end

    it 'frequency_numberが範囲外だと無効' do
      task = build(:task, frequency_number: 999)
      expect(task).not_to be_valid
    end

    it 'start_dateよりend_dateが前だと無効' do
      task = build(:task, start_date: Date.today, end_date: Date.yesterday)
      task.valid?
      expect(task.errors[:end_date]).to include(
        I18n.t('activerecord.errors.models.task.attributes.end_date.after_or_equal_to_start_date')
      )
    end
  end

  describe '#all_days' do
    it '期間日数が計算される' do
      task = build(:task, start_date: Date.today, end_date: Date.today + 2)
      expect(task.all_days).to eq 3
    end
  end

  describe '#completion_rate' do
    it '完了率が0%のとき' do
      task = create(:task, start_date: Date.today, end_date: Date.today)
      expect(task.completion_rate).to eq 0
    end

    it '完了率が100%のとき' do
      task = create(:task, start_date: Date.today, end_date: Date.today)
      create(:task_log, task: task, executed_on: Date.today)
      expect(task.completion_rate).to eq 100.0
    end
  end

  describe '#update_completed_status' do
    let(:task) { create(:task) }

    context 'completion_rate が 100 のとき' do
      before do
        allow(task).to receive(:completion_rate).and_return(100)
        task.update_completed_status
      end

      it 'completed カラムが true になること' do
        expect(task.reload.completed).to be true
      end
    end

    context 'completion_rate が 100 未満のとき' do
      before do
        allow(task).to receive(:completion_rate).and_return(60)
        task.update_completed_status
      end

      it 'completed カラムが false になること' do
        expect(task.reload.completed).to be false
      end
    end
  end

  describe '.in_progress_for' do
    let(:user) { create(:user) }
    let!(:task1) { create(:task, user: user, completed: false, title: "筋トレ") }
    let!(:task2) { create(:task, user: user, completed: true, title: "瞑想") }

    it '未完了のタスクのみ返すこと' do
      expect(Task.in_progress_for(user)).to contain_exactly(task1)
    end

    it 'キーワードでフィルターされた未完了タスクを返すこと' do
      expect(Task.in_progress_for(user, "筋")).to contain_exactly(task1)
      expect(Task.in_progress_for(user, "瞑")).to be_empty
    end
  end

  describe '.completed_for' do
    let(:user) { create(:user) }
    let!(:task1) { create(:task, user: user, completed: false, title: "筋トレ") }
    let!(:task2) { create(:task, user: user, completed: true, title: "瞑想") }

    it '完了済みのタスクのみ返すこと' do
      expect(Task.completed_for(user)).to contain_exactly(task2)
    end

    it 'キーワードでフィルターされた完了済みタスクを返すこと' do
      expect(Task.completed_for(user, "瞑")).to contain_exactly(task2)
      expect(Task.completed_for(user, "筋")).to be_empty
    end
  end

  describe '#executed_today?' do
    it '今日の実行ログがあればtrueを返す' do
      task = create(:task)
      create(:task_log, task:, executed_on: Date.today)
      expect(task.executed_today?).to be true
    end
  end
end
