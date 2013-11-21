# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    body "Lorem ipsum dipsum oleafactorum nasuntorum"
    user
    topic
  end
end
