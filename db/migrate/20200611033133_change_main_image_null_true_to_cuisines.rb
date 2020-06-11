class ChangeMainImageNullTrueToCuisines < ActiveRecord::Migration[5.1]
  def up
    change_column :cuisines, :main_image, :string, null: true, comment: "メイン画像"
  end

  def down
    change_column :cuisines, :main_image, :string, null: false, comment: "メイン画像"
  end
end
