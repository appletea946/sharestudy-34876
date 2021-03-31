FactoryBot.define do
  factory :user_group_relation do
    association :user
    association :group
  end
end
