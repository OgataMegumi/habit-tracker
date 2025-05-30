require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    it '有効なFactoryであれば有効' do
      expect(build(:task)).to be_valid
    end

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

  describe '#scheduled_periods' do
    it '期間日数が計算される' do
      task = build(:task, start_date: Date.today, end_date: Date.today + 2)
      expect(task.scheduled_periods).to eq 3
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

  describe '#executed_today?' do
    it '今日の実行ログがあればtrueを返す' do
      task = create(:task)
      create(:task_log, task:, executed_on: Date.today)
      expect(task.executed_today?).to be true
    end
  end
end
