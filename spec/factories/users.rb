# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "bob##{n}" }
    sequence(:email) { |n| "user#{n}@bloccit.com" }
    password "password"
  end
end
