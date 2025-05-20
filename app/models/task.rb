class Task < ApplicationRecord
  include TaskContents

  has_many :task_logs, dependent: :destroy
  belongs_to :user

  FREQUENCY_RANGE = (1..12).to_a
  CATEGORIES = CATEGORIES_GROUPS.values.flatten

  validates :frequency_number, inclusion: { in: FREQUENCY_RANGE }
  validates :frequency_unit, inclusion: { in: FREQUENCY_UNITS_LIST }
  validates :category, inclusion: { in: CATEGORIES }
  validates :color, inclusion: { in: COLORS }
  validates :title, length: { maximum: 15 }

  def color_code
    COLOR_CODES[self.color]
  end

  def scheduled_periods
    (end_date - start_date).to_i + 1
  end

  def completion_rate
    return 0 if scheduled_periods.zero?
    (TaskLog.done_days(self).to_f / scheduled_periods * 100).round(1)
  end

  def completed?
    completion_rate == 100
  end

  def self.dates_in_current_month
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    (start_date..end_date).to_a
  end

  def self.in_progress_for(user, keyword = nil)
    tasks = user.tasks.includes(:task_logs)
    tasks = tasks.select { |t| !t.completed? }
    keyword.present? ? tasks.select { |t| t.title.include?(keyword) } : tasks
  end

  def self.completed_for(user, keyword = nil)
    tasks = user.tasks.includes(:task_logs)
    tasks = tasks.select(&:completed?)
    keyword.present? ? tasks.select { |t| t.title.include?(keyword) } : tasks
  end
end
