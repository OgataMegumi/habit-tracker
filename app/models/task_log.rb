class TaskLog < ApplicationRecord
  belongs_to :task
  belongs_to :user, optional: true

  validates :executed_on, presence: true

  after_create  :update_task_completed_status
  after_update  :update_task_completed_status

  def self.completed_days(task)
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
                           .group(:executed_on)
                           .count

    tasks = Task.where(user: user)
    assigned_tasks_by_date = date_range.each_with_object({}) do |date, hash|
      hash[date] = tasks.where("start_date <= ? AND end_date >= ?", date, date).count
    end

    date_range.map do |date|
      done = progress_data[date] || 0
      assigned_tasks = assigned_tasks_by_date[date]

      percentage = assigned_tasks.positive? ? ((done.to_f / assigned_tasks) * 100).round : 0

      [ date.strftime("%m/%d"), percentage ]
    end
  end

  private

  def update_task_completed_status
    task.update_completed_status if task.present?
  end
end
