# frozen_string_literal: true

class CategoryAssign < ApplicationRecord
  belongs_to :category
  belongs_to :drawing
end
