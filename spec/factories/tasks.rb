# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'task_title' }
    content { 'task_content' }
    deadline { Time.current }
    status { 1 }
  end
end
