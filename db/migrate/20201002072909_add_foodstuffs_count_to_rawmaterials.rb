class AddFoodstuffsCountToRawmaterials < ActiveRecord::Migration[5.1]
  def self.up
    add_column :rawmaterials, :foodstuffs_count, :integer, null: false, default: 0, after: :foodcategory_id
  end

  def self.down
    remove_column :rawmaterials, :foodstuffs_count
  end
end
