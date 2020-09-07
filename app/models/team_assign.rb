# frozen_string_literal: true

class TeamAssign < ApplicationRecord
  belongs_to :team
  belongs_to :user
end
