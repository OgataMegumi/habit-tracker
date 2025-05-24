FactoryBot.define do
  factory :task do
    user
    title { "テストタスク" }
    description { "詳細" }
    message { "メッセージ" }
    start_date { Date.today }
    end_date { Date.today + 4 }
    frequency_number { 1 }
    frequency_unit { TaskContents::FREQUENCY_UNITS_LIST.first }
    category { TaskContents::CATEGORIES_GROUPS.values.flatten.first }
    color    { TaskContents::COLORS.first }
  end
end
