class Customer < ApplicationRecord
  has_one_attached :icon
  belongs_to :company
  has_many :projects
  has_many :drawings, through: :projects
end
