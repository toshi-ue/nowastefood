class AddRawmaterialIdToNutrients < ActiveRecord::Migration[5.1]
  def up
    add_reference :nutrients, :rawmaterial, foreign_key: true
  end

  def down
    remove_reference :nutrients, :rawmaterial, foreign_key: true
  end
end
