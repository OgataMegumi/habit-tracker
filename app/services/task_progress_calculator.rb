class TaskProgressCalculator
  def initialize(task_logs)
    @task_logs = task_logs
  end

  def call
    (Date.today - 13..Date.today).each_with_object({}) do |date, data|
      data[date] = calculate_daily_progress(date)
    end
  end

  private

  def calculate_daily_progress(date)
    logs_for_date = @task_logs.select { |log| log.executed_on == date }
    return 0 if logs_for_date.empty?

    completed_tasks = logs_for_date.count
    total_tasks = Task.where(start_date: ..date, end_date: date..).count
    return 0 if total_tasks.zero?

    (completed_tasks.to_f / total_tasks * 100).round(1)
  end
end
