class RemoveMinQuantityToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    remove_column :rawmaterials, :min_quantity
  end

  def down
    add_column :rawmaterials, :min_quantity, after: :hiragana
  end
end
