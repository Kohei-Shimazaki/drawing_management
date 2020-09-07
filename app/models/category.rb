# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_assigns, dependent: :destroy
  has_many :drawings, through: :category_assigns, source: :drawing
  belongs_to :company

  validates :name, presence: true, length: { maximum: 100 }
end
