class Evidence < ApplicationRecord
  has_one_attached :content
  belongs_to :task
end
