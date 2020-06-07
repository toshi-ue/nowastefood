class ChangeColumnsToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    add_index :rawmaterials, :name, unique: true
  end

  def down
    remove_index :rawmaterials, :name
  end
end
