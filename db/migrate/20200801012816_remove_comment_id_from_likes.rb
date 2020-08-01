class RemoveCommentIdFromLikes < ActiveRecord::Migration[5.2]
  def up
    remove_column :likes, :comment_id
  end

  def down
    add_column :likes, :comment_id, :integer
  end
end
