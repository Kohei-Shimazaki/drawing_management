# frozen_string_literal: true

FactoryBot.define do
  factory :notification_read do
    user { nil }
    notification { nil }
  end
end
