class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :content

      t.timestamps
      #idも遺j同的に作成されている。
    end
  end
end
