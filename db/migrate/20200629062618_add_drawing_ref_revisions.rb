class AddDrawingRefRevisions < ActiveRecord::Migration[5.2]
  def change
    add_reference :revisions, :drawing, foreign_key: true
  end
end
