# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { 1 }
    phone_number { '090-000-0001' }
    location { 'MyString' }
    overview { 'MyText' }
  end
end
