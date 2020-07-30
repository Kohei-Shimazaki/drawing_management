class Project < ApplicationRecord
  belongs_to :customer
  has_many :drawings
  has_many :tasks, through: :drawings
  has_many :questions, through: :tasks
end
