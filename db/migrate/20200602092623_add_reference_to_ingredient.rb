class AddReferenceToIngredient < ActiveRecord::Migration[5.1]
  def up
    add_index :ingredients, :name, unique: true
  end

  def down
    remove_index :ingredients, :name
  end
end
