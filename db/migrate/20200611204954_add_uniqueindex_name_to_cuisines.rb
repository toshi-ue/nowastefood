class AddUniqueindexNameToCuisines < ActiveRecord::Migration[5.1]
  def up
    add_index :cuisines, :name, unique: true
  end

  def down
    remove_index :cuisines, :name
  end
end
