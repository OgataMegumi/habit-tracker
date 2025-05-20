class TaskLog < ApplicationRecord
  belongs_to :task
  validates :executed_on, presence: true

  def self.done_days(task)
    where(task_id: task.id, executed_on: task.start_date..task.end_date)
      .distinct
      .count(:executed_on)
  end

  def self.toggle_for(task, date)
    log = task.task_logs.find_by(executed_on: date)
    if log
      log.destroy
    else
      create!(task: task, executed_on: date)
    end
  end

  def self.calculate_daily_progress(user)
    joins(:task)
      .where(tasks: { user_id: user.id })
      .group(:executed_on)
      .count
  end
end
