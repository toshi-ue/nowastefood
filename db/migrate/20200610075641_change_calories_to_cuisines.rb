class ChangeCaloriesToCuisines < ActiveRecord::Migration[5.1]
  def up
    change_column :cuisines, :calories, :string, null: true
  end

  def down
    change_column :cuisines, :calories, :string, null: false, default: 0
  end
end
