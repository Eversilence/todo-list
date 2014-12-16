class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.boolean :completed, default: false
      t.date :deadline
      t.integer :project_id

      t.timestamps
    end
  end
end
