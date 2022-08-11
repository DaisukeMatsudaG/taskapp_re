class AddDeadlinesToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline, :date
  end
end