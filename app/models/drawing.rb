class Drawing < ApplicationRecord
  has_many :category_assigns, dependent: :destroy
  has_many :categories, through: :category_assigns, source: :category
  has_many :revisions, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
