class RemoveTitleFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :title, :string
  end
end
