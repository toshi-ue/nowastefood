class AddDescriptionToCuisines < ActiveRecord::Migration[5.1]
  def up
    add_column :cuisines, :description,  :string, after: :cooking_time
  end

  def down
    remove_column :cuisines, :description, :string
  end
end
