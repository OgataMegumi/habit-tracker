class AddUserIdToTaskLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :task_logs, :user_id, :integer
    add_index :task_logs, :user_id
  end
end
