FactoryBot.define do
  factory :task do
    association :user
    start_date { Date.today }
    end_date { Date.today + 10 }
    frequency_number { Task::FREQUENCY_RANGE.sample }
    frequency_unit { FREQUENCY_UNITS_LIST.sample }
    category { Task::CATEGORIES.sample }
    color { COLORS.sample }
  end
end
