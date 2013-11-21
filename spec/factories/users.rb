# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "bob##{n}" }
    sequence(:email) { |n| "user#{n}@bloccit.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
