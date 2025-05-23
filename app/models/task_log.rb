class TaskLog < ApplicationRecord
  belongs_to :task
  belongs_to :user, optional: true

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
      create!(task: task, user_id: task.user_id, executed_on: date)
    end
  end

  def self.calculate_daily_progress(user)
    joins(:task)
      .where(tasks: { user_id: user.id })
      .group(:executed_on)
      .count
  end

  def self.calculate_chart_data(user)
    start_date = 13.days.ago.to_date
    end_date = Date.today
    date_range = (start_date..end_date).to_a

    progress_data = TaskLog.where(user_id: user.id, executed_on: start_date..end_date)
                            .group("DATE(executed_on)")
                            .count

    date_range.map do |date|
      done = progress_data[date] || 0

      assigned_tasks = Task.where(user: user)
                     .where("start_date <= ? AND end_date >= ?", date, date)
                     .count

      percentage = if assigned_tasks > 0
                     (done.to_f / assigned_tasks * 100).round
      else
                     0
      end

      [ date.strftime("%m/%d"), percentage ]
    end
  end
end
