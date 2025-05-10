class TaskProgressCalculator
    def initialize(tasks)
        @task = tasks
    end

    def call
        progress_data = {}
        # cumulative_progress = 0

        (Date.today - 13..Date.today).each do |date|
            total_progress = 0.0
            
            @task.each do |task|
                task_progress = calculate_task_progress(task, date)
                total_progress += task_progress
            end

            progress_data[date] = (total_progress / @task.length).round(1) # タスク数で割って平均を出す
        end
    
        progress_data
    end

    private

    def calculate_task_progress(task, date)
        # タスクの期間内かどうか
        if date >= task.start_date && date <= task.end_date
          # 進捗率を1日ごとの進捗割合で計算（例：タスク期間が10日なら1日あたり10%ずつ進む）
          days_in_progress = (date - task.start_date + 1).to_i
          completion_rate = (days_in_progress.to_f / task.scheduled_days) * 100
        else
          completion_rate = 0
        end
    
        completion_rate
      end
end