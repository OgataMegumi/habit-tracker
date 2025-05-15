FactoryBot.define do
  factory :task_log do
    association :task
    done { [ true, false ].sample }
  end
end
