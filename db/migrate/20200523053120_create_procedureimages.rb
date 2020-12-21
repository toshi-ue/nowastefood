class CreateProcedureimages < ActiveRecord::Migration[5.1]
  def change
    create_table :procedureimages do |t|
      t.string :image, null: false, comment: "料理手順を示す画像"
      t.integer :order, null: false, comment: "料理手順画像を表示する順番"
      t.references :cuisine, index: true, foreign_key: true, comment: "料理id"
      t.timestamps
    end
  end
end
