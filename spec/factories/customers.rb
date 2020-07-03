FactoryBot.define do
  factory :customer do
    name { 1 }
    phone_number { "MyString" }
    location { "MyString" }
    icon { "MyText" }
    overview { "MyText" }
  end
end
