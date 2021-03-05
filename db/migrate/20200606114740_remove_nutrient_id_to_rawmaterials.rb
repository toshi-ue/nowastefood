class RemoveNutrientIdToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    remove_index :rawmaterials, :nutrient_id
    remove_column :rawmaterials, :nutrient_id, :integer
  end

  def down
    add_column :rawmaterials, :nutrient_id, :integer
    add_index :rawmaterials, :nutrient_id
  end
end
