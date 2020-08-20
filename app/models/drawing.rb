class Drawing < ApplicationRecord
  belongs_to :team
  belongs_to :project
  has_one :customer, through: :project
  has_many :category_assigns, dependent: :destroy
  has_many :categories, through: :category_assigns, source: :category
  has_many :revisions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :questions, through: :tasks

  validates :title, presence: true, length: {maximum: 100}
  validates :drawing_number, presence: true, length: {maximum: 20}, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
