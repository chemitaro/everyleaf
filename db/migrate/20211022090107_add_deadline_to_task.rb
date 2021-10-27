class AddDeadlineToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :datetime, null: false, default: -> { "now()" }
  end
end
