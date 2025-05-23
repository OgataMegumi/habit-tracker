class AddShowCompletedTasksToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :show_completed_tasks, :boolean, default: true, null: false
  end
end
