FactoryBot.define do
  factory :article do
    title       { 'title' }
    content     { 'content' }
    association :user
  end
end
