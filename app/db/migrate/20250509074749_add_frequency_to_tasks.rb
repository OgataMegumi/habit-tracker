class AddFrequencyToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :frequency_number, :integer
    add_column :tasks, :frequency_unit, :string
    add_column :tasks, :frequency_in_days, :float
  end
end
