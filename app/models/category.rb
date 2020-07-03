class Category < ApplicationRecord
  has_many :category_assigns, dependent: :destroy
  has_many :drawings, through: :category_assigns, source: :drawing
end
