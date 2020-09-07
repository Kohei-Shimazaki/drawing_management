# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'MyString' }
    explanation { 'MyText' }
    location { 'MyString' }
  end
end
