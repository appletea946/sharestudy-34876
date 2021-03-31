FactoryBot.define do
  factory :group do
    name        { 'name' }
    password    { 'password' }
    association :user
  end
end
