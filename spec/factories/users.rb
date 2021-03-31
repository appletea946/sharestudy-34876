FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.email }
    password              { 'abc123' }
    password_confirmation { password }
    introduction          { "This is your introduction. Let's write yourself!" }

    after(:build) do |message|
      message.image.attach(io: File.open('app/assets/images/random0.png'), filename: 'random0.png')
    end
  end
end
