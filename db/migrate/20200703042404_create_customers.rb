class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.integer :name
      t.string :phone_number
      t.string :location
      t.text :icon
      t.text :overview

      t.timestamps
    end
  end
end
