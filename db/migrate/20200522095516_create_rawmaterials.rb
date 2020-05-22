class CreateRawmaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :rawmaterials do |t|
      t.string :name, null: false, comment: "原材料名"
      t.integer :min_quantity, null: false, comment: "原材料最小数量"
      t.references :applicant, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.references :approver, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.references :foodcategory, index: true, foreing_key: true
      t.references :nutrient, index: true, foreing_key: true
      t.timestamps
    end
  end
end
