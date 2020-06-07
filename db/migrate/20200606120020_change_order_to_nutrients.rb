class ChangeOrderToNutrients < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :nutrients, column: :rawmaterial_id
    remove_index :nutrients, :rawmaterial_id
    remove_column :nutrients, :rawmaterial_id
    add_reference :nutrients, :rawmaterial, foreign_key: true, after: :id
  end

  def down
    remove_foreign_key :nutrients, column: :rawmaterial_id
    remove_index :nutrients, :rawmaterial_id
    remove_column :nutrients, :rawmaterial_id
    add_reference :nutrients, :rawmaterial, foreign_key: true
  end
end
