class Team < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :team_assigns, dependent: :destroy
  has_many :members, through: :team_assigns, source: :user
end
