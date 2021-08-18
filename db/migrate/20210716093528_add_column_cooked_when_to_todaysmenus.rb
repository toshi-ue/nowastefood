class AddColumnCookedWhenToTodaysmenus < ActiveRecord::Migration[6.0]
  def up
    add_column :todaysmenus, :cooked_when, :integer, after: :serving_count
  end

  def down
    remove_column :todaysmenus, :cooked_when, :integer
  end
end
