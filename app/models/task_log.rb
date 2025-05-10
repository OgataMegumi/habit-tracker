class TaskLog < ApplicationRecord
  belongs_to :task
  validates :executed_on, presence: true

  def self.done_days(task)
    where(task_id: task.id, executed_on: task.start_date..task.end_date)
      .distinct
      .count(:executed_on)
  end

  def self.mark_as_done!(task, data)
    log = task.task_logs.find_by(executed_on: data)
    if log
      log.destroy
    else
      task.task_logs.create!(executed_on: data)
    end
  end

  def self.calculate_daily_progress
    task_logs = all.includes(:task)
    TaskProgressCalculator.new(task_logs).call
  end
end
