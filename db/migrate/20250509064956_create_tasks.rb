class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :frequency
      t.text :message
      t.datetime :start_date
      t.datetime :end_date
      t.string :color

      t.timestamps
    end
  end
end
