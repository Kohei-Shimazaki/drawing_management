# frozen_string_literal: true

FactoryBot.define do
  factory :drawing do
    title { 'MyString' }
    drawing_number { 1 }
    explanation { 'MyText' }
  end
end
