class CreateFoodstuffs < ActiveRecord::Migration[5.1]
  def change
    create_table :foodstuffs do |t|
      t.integer :cooking_time, null: false, comment: "数量"
      t.integer :measure_unit, null: false, comment: "単位"
      t.references :cuisine, add_index: true, foregin_key: true, comment: "料理id"
      t.references :rawmaterial, add_index: true, foregin_key: true, comment: '原材料id'
      t.references :ingredient, add_index: true, foregin_key: true, comment: '部位id'
      t.references :cookedstate, add_index: true, foregin_key: true, comment: '加工された状態の名前id'
      t.timestamps
    end
  end
end
