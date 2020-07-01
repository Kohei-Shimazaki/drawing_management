class AddDrawingRefTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :drawing, foreign_key: true
  end
end
