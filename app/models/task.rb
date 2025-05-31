class Task < ApplicationRecord
  include TaskContents

  has_many :task_logs, dependent: :destroy
  belongs_to :user

  FREQUENCY_RANGE = [ 1 ]
  CATEGORIES = CATEGORIES_GROUPS.values.flatten

  validates :frequency_number, inclusion: { in: FREQUENCY_RANGE }
  validates :frequency_unit, inclusion: { in: FREQUENCY_UNITS_LIST }
  validates :category, inclusion: { in: CATEGORIES }
  validates :color, inclusion: { in: COLORS }
  validates :title, length: { maximum: 15 }
  validates :description, length: { maximum: 50 }
  validates :message, length: { maximum: 50 }
  validates :title, presence: true
  validate :end_date_after_start_date

  def color_code
    COLOR_CODES[self.color]
  end

  def all_days
    (end_date - start_date).to_i + 1
  end

  def completion_rate
    return 0 if all_days.zero?

    completed_days = TaskLog.completed_days(self)
    (completed_days.to_f / all_days * 100).round(1)
  end

  def update_completed_status
    update_column(:completed, completion_rate == 100)
  end

  def self.current_month
    Date.current.month
  end

  def self.in_progress_for(user, keyword = nil)
    filtered_tasks_for(user, completed: false, keyword: keyword)
  end

  def self.completed_for(user, keyword = nil)
    filtered_tasks_for(user, completed: true, keyword: keyword)
  end

  def executed_today?
    task_logs.exists?(executed_on: Date.current)
  end

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, :after_or_equal_to_start_date)
    end
  end

  def self.filtered_tasks_for(user, completed:, keyword: nil)
    tasks = user.tasks.includes(:task_logs).where(completed: completed)
    keyword.present? ? tasks.where("title LIKE ?", "%#{keyword}%") : tasks
  end
end
