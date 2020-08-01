class RemoveIsReadFromMessageReads < ActiveRecord::Migration[5.2]
  def up
    remove_column :message_reads, :is_read
  end
  def down
    add_column :message_reads, :is_read, :boolean
  end
end
