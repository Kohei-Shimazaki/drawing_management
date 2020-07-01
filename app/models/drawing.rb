class Drawing < ApplicationRecord
  has_many :revisions, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
