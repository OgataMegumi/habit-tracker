FactoryBot.define do
  factory :comment do
    user { user }
    content { "MyText" }
    parent { nil }
  end
end
