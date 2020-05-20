class CreateFoodcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :foodcategories do |t|
      t.string :name, null: false, comment: "食材区分名(肉、野菜、魚、炭水化物など)"
      t.references :manager, null: false, index: true, foreign_key: true, comment: "申請した人のid(管理者id)"
      t.references :approver, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.timestamps
    end
  end
end
