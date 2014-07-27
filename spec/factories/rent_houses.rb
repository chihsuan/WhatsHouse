# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rent_house do
    use "MyString"
    structure "MyString"
    address "MyString"
    price 1
    owner "MyString"
    tel "MyString"
    information "MyString"
    people 1
    user { |a| [a.association(:user)] }
  end

end

