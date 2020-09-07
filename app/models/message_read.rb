# frozen_string_literal: true

class MessageRead < ApplicationRecord
  belongs_to :user
  belongs_to :message
end
