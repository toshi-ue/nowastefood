class AddReferenceToFoodcategories < ActiveRecord::Migration[5.1]
  def up
    add_index :foodcategories, :name, unique: true
  end

  def down
    remove_index :foodcategories, :name
  end
end
