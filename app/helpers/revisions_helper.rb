# frozen_string_literal: true

module RevisionsHelper
  def sort_by_revision_number(revision)
    revision.order(revision_number: :desc)
  end
end
