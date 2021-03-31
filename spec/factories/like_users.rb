FactoryBot.define do
  factory :like_user do
    give_user     { 1 }
    receive_user  { 3 }
  end
end
