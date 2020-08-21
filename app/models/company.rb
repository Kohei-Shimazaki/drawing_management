class Company < ApplicationRecord
  has_one_attached :icon
  has_many :teams, dependent: :destroy
  has_many :drawings, through: :teams
  has_many :tasks, through: :drawings
  has_many :questions, through: :tasks
  has_many :comments, through: :questions
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id, optional: true
  has_many :users, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :projects, through: :customers
  has_many :categories, dependent: :destroy

  validates :name, presence: true, length: {maximum: 100}
  validates :phone_number, presence: true, format: {with: /\A\d{1,4}-\d{1,4}-\d{3,4}\z/}
end
