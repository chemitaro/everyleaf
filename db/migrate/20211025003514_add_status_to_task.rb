class AddStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string, null: false, default: "ĉŞçĉ"
  end
end
