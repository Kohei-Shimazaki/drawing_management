class Company < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id, optional: true
  has_many :users, dependent: :destroy
end
