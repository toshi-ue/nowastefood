class ChangeVit12ToNutrients < ActiveRecord::Migration[5.1]
  def up
    rename_column :nutrients, :vit_12, :vit_b12
  end

  def down
    rename_column :nutrients, :vit_b12, :vit_12
  end
end
