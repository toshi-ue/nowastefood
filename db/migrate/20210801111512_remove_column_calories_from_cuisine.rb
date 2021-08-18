class RemoveColumnCaloriesFromCuisine < ActiveRecord::Migration[6.0]
  def up
    remove_column :cuisines, :calories, :string
  end

  def down
    add_column :cuisines, :calories, :string
  end
end
