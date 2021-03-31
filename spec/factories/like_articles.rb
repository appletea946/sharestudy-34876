FactoryBot.define do
  factory :like_article do
    association :user
    association :article
  end
end
