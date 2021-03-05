class AddRawmaterialIdToNutrients2 < ActiveRecord::Migration[5.1]
  def change
    add_reference :nutrients, :rawmaterial, foreign_key: true, after: :id
  end
end
