class Drawing < ApplicationRecord
  has_many :revisions, dependent: :destroy
end
