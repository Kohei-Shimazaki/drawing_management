FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'sample' }
    email { 'sample@example.com' }
    employee_number { 100001 }
    password { 'password' }
    password_confirmation { 'password' }
  end
  factory :user2, class: User do
    id { 2 }
    name { 'sample2' }
    email { 'sample2@example.com'}
    employee_number { 100002 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
