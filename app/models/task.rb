class Task < ApplicationRecord
    include TaskContents

    has_many :task_logs, dependent: :destroy

    FREQUENCY_RANGE = (1..12).to_a
    CATEGORIES = CATEGORIES_GROUPS.values.flatten
  
    validates :frequency_number, inclusion: { in: FREQUENCY_RANGE }
    validates :frequency_unit, inclusion: { in: FREQUENCY_UNITS_LIST }
    validates :category, inclusion: { in: CATEGORIES }
    validates :color, inclusion: { in: COLORS }

    def color_code
        COLOR_CODES[self.color]
    end

    def toggle_execution!(data)
        log = task_logs.find_by(executed_on: data)
        if log
            log.destroy
        else
            task_logs.create!(executed_on: data)
        end
    end

    def total_days
        (end_date - start_date).to_i + 1
    end

    def executed_days
        task_logs.where(executed_on: start_date..end_date).distinct.count(:executed_on)
    end

    def progress_percentage
        return 0 if total_days.zero?
        (executed_days.to_f / total_days * 100).round(1)
    end

    def self.dates_in_current_month
        start_date = Date.today.beginning_of_month
        end_date = Date.today.end_of_month
        (start_date..end_date).to_a
    end
end