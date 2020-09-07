# frozen_string_literal: true

FactoryBot.define do
  factory :revision do
    revision_number { 1 }
    comment { 'MyText' }
  end
end
