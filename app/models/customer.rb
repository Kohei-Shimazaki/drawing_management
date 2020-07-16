class Customer < ApplicationRecord
  has_one_attached :icon
  belongs_to :company
end
