class AddUnitidToRawmaterials < ActiveRecord::Migration[5.1]
  def change
    add_reference :rawmaterials, :unit, foreign_key: true, after: :min_quantity
  end

  def down
    remove_reference :rawmaterials, :unit, foreign_key: true, after: :min_quantity
  end
end
