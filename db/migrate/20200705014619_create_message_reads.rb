class CreateMessageReads < ActiveRecord::Migration[5.2]
  def change
    create_table :message_reads do |t|
      t.integer :user_id
      t.integer :message_id
      t.boolean :is_read, default: false, null: false

      t.timestamps
    end
  end
end
