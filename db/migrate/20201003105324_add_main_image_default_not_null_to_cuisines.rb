class AddMainImageDefaultNotNullToCuisines < ActiveRecord::Migration[5.1]
  def up
    change_column :cuisines, :main_image, :string, null: false
  end
  def down
    change_column :cuisines, :main_image, :string, null: true
  end
end
