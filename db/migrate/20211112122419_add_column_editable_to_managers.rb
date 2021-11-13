class AddColumnEditableToManagers < ActiveRecord::Migration[6.0]
  def up
    add_column :managers, :editable, :boolean, default: false, null: false
  end

  def down
    remove_column :managers, :editable, :boolean
  end
end
