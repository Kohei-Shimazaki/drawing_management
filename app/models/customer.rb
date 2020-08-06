class Customer < ApplicationRecord
  has_one_attached :icon
  belongs_to :company
  has_many :projects, dependent: :destroy
  has_many :drawings, through: :projects

  validates :name, presence: true, length: {maximum: 100}
  validates :phone_number, presence: true, format: {with: /\A\d{1,4}-\d{1,4}-\d{3,4}\z/}
end
