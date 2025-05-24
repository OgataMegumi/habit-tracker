require 'rails_helper'

RSpec.describe TaskLog, type: :model do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user, start_date: Date.today - 5, end_date: Date.today + 5) }

  describe '.done_days' do
    it '期間内のユニークな実行日数をカウントする' do
      create(:task_log, task: task, executed_on: Date.today - 1)
      create(:task_log, task: task, executed_on: Date.today)
      create(:task_log, task: task, executed_on: Date.today + 1)
      create(:task_log, task: task, executed_on: Date.today + 6) # 期間外

      logs_in_range = TaskLog.where(task_id: task.id, executed_on: task.start_date..task.end_date).pluck(:executed_on)
      puts "logs_in_range: #{logs_in_range}"
    
      result = TaskLog.done_days(task)
      puts "done_days result: #{result}"

      expect(TaskLog.done_days(task)).to eq 3
    end
  end

  describe '.toggle_for' do
    context 'ログが存在しない場合' do
      it '新規作成される' do
        expect {
          TaskLog.toggle_for(task, Date.today)
        }.to change { TaskLog.count }.by(1)
        log = TaskLog.find_by(task: task, executed_on: Date.today)
        expect(log).not_to be_nil
        expect(log.user_id).to eq user.id
      end
    end

    context 'ログが存在する場合' do
      before do
        create(:task_log, task: task, executed_on: Date.today)
      end

      it '該当ログが削除される' do
        expect {
          TaskLog.toggle_for(task, Date.today)
        }.to change { TaskLog.count }.by(-1)
      end
    end
  end

  describe '.calculate_daily_progress' do
    it 'ユーザーのタスクログを日付ごとに集計する' do
      create(:task_log, task: task, executed_on: Date.today)
      create(:task_log, task: task, executed_on: Date.today - 1)

      result = TaskLog.calculate_daily_progress(user)
      expect(result).to be_a(Hash)
      expect(result[Date.today]).to eq 1
      expect(result[Date.today - 1]).to eq 1
    end
  end

  describe '.calculate_chart_data' do
    let(:date_range) { (13.days.ago.to_date..Date.today).to_a }
  
    context 'ユーザーに複数のタスクがあり、一部のタスクログがある場合' do
      before do
        create_list(:task, 3, user: user, start_date: Date.today - 10, end_date: Date.today + 10)
        create(:task_log, task: Task.where(user: user).first, user: user, executed_on: Date.today)
      end
  
      it '13日前から今日までの日付ごとの進捗率を返す' do
        chart_data = TaskLog.calculate_chart_data(user)
  
        expect(chart_data.size).to eq date_range.size

        today_label = Date.today.strftime("%m/%d")
        today_data = chart_data.find { |date, _| date == today_label }
  
        expect(today_data).not_to be_nil
        expect(today_data[1]).to eq 33
      end
    end
  
    context 'ユーザーに割り当てられたタスクがない場合' do
      before do
        other_user = create(:user)
        create(:task, user: other_user, start_date: Date.today - 1, end_date: Date.today + 1)
      end
  
      it 'すべての日付で進捗率は0%' do
        chart_data = TaskLog.calculate_chart_data(user)
        expect(chart_data.all? { |_, percent| percent.zero? }).to be true
      end
    end
  end  
end
