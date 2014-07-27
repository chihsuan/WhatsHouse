# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "test@mail.com"
    password "MyString11"
    password_confirmation 'MyString11'

  end
end
