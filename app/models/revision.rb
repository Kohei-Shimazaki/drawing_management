class Revision < ApplicationRecord
  belongs_to :drawing
  has_one_attached :content
end
