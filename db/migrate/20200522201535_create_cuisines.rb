class CreateCuisines < ActiveRecord::Migration[5.1]
  def change
    create_table :cuisines do |t|
      t.string :name, null: false, comment: "料理名"
      t.string :calories, null: false, comment: "摂取カロリー"
      t.integer :cooking_time, null: false, comment: "調理時間"
      t.integer :cooking_time, null: false, comment: "お手軽度, (enumで、低、中・高)"
      t.string :main_image, null: false, comment: "メイン画像"
      t.timestamps
    end
  end
end
