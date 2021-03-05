class AddDefaultServingCountToTodaysmenu < ActiveRecord::Migration[5.1]
  def up
    change_column :todaysmenus, :serving_count, :integer, null: false, default: 1
  end
  def down
    change_column :todaysmenus, :serving_count, :integer
  end
end
