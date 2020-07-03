class CreateCategoryAssigns < ActiveRecord::Migration[5.2]
  def change
    create_table :category_assigns do |t|
      t.integer :category_id
      t.integer :drawing_id

      t.timestamps
    end
  end
end
