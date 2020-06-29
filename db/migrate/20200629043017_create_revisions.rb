class CreateRevisions < ActiveRecord::Migration[5.2]
  def change
    create_table :revisions do |t|
      t.integer :revision_number
      t.text :content
      t.text :comment

      t.timestamps
    end
  end
end
