class RemoveEstimatedTimeFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :estimated_time, :string
  end
end
