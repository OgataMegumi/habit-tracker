class AddUniqueIndexToTaskLogsOnTaskIdAndExecutedOn < ActiveRecord::Migration[8.0]
  def change
    add_index :task_logs, [ :task_id, :executed_on ], unique: true
  end
end
