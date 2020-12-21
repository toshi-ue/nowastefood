class CreateCookedstates < ActiveRecord::Migration[5.1]
  def change
    create_table :cookedstates do |t|
      t.string :name, comment: '加工された状態の名前'
      t.references :applicant, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.references :approver, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.timestamps
    end
  end
end
