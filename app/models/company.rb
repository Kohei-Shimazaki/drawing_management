class Company < ApplicationRecord
  has_one_attached :icon
  has_many :teams, dependent: :destroy
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id, optional: true
  has_many :users, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :categories
end
