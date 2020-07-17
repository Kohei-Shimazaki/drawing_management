class Project < ApplicationRecord
  belongs_to :customer
  has_many :drawings
end
