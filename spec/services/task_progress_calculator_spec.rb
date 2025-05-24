require 'rails_helper'

RSpec.describe TaskProgressCalculator do
  let(:user) { create(:user) }

  describe '#call' do
    context 'タスクがなく、タスクログもない場合' do
      it 'すべての日付で進捗率が0%になる' do
        calculator = TaskProgressCalculator.new([])

        result = calculator.call

        expect(result.keys.size).to eq 14
        expect(result.values.uniq).to eq [0]
      end
    end

    context '対象日に1件のタスクと1件のタスクログがある場合' do
      it 'その日の進捗率は100%になる' do
        task = create(:task, user: user, start_date: Date.today - 5, end_date: Date.today + 5)
        log = create(:task_log, task: task, executed_on: Date.today)

        calculator = TaskProgressCalculator.new([log])
        result = calculator.call

        expect(result[Date.today]).to eq 100.0
      end
    end

    context '対象日に3件のタスク中1件だけログがある場合' do
      it 'その日の進捗率は33.3%になる' do
        create_list(:task, 3, user: user, start_date: Date.today - 5, end_date: Date.today + 5)
        log = create(:task_log, task: Task.first, executed_on: Date.today)

        calculator = TaskProgressCalculator.new([log])
        result = calculator.call

        expect(result[Date.today]).to eq 33.3
      end
    end

    context 'ログはあるが、その日にタスクがない場合' do
      it '進捗率は0%になる' do
        task = create(:task, user: user, start_date: Date.today - 10, end_date: Date.today - 5)
        log = create(:task_log, task: task, executed_on: Date.today)

        calculator = TaskProgressCalculator.new([log])
        result = calculator.call

        expect(result[Date.today]).to eq 0
      end
    end
  end
end
