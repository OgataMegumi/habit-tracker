class CreateTaskLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :task_logs do |t|
      t.references :task, null: false, foreign_key: true
      t.date :executed_on

      t.timestamps
    end
  end
end
