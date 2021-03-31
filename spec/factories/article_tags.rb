FactoryBot.define do
  factory :articles_tag do
    title     { 'title' }
    content   { 'content' }
    name      { 'tag' }
    user_id   { 1 }
    group_id  { 1 }
  end
end
