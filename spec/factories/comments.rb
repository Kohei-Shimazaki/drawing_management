# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    attachment { 'MyText' }
  end
end
