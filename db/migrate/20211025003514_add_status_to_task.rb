class AddStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string, null: false, default: "未着手"
  end
end
