class AddPriorityindexToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :priority_index, :integer
  end
end
