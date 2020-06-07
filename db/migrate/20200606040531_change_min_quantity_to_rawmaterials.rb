class ChangeMinQuantityToRawmaterials < ActiveRecord::Migration[5.1]
  def change
  end

  def up
    change_column :rawmaterials, :min_quantity, :integer, default: 1
  end

  def down
    change_column_default :rawmaterials, :min_quantity, nil
  end
end
