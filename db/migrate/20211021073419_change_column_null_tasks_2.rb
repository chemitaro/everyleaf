class ChangeColumnNullTasks2 < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :content, :text, null: false
  end
end
