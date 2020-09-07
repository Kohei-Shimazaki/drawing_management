# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'MyString' }
    phone_number { '090-101-1001' }
    location { 'MyString' }
    overview { 'MyText' }
  end
end
