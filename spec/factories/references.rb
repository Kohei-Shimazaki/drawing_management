# frozen_string_literal: true

FactoryBot.define do
  factory :reference do
    content { 'MyText' }
    comment { 'MyString' }
    text { 'MyString' }
    task { nil }
  end
end
