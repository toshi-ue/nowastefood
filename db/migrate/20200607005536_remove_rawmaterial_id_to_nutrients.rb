class RemoveRawmaterialIdToNutrients < ActiveRecord::Migration[5.1]
  def change
    remove_reference :nutrients, :rawmaterial, foreign_key: true
  end
end
