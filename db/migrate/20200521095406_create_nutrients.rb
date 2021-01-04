class CreateNutrients < ActiveRecord::Migration[5.1]
  def change
    create_table :nutrients do |t|
      t.integer :lipid, comment: '脂質'
      t.integer :carbonhydrate, comment: '炭水化物'
      t.integer :protein, comment: 'タンパク質'
      t.integer :vit_a, comment: 'ビタミンA'
      t.integer :vit_d, comment: 'ビタミンD'
      t.integer :vit_e, comment: 'ビタミンE'
      t.integer :vit_k, comment: 'ビタミンK'
      t.integer :vit_b1, comment: 'ビタミンB1'
      t.integer :vit_b2, comment: 'ビタミンB2'
      t.integer :vit_b6, comment: 'ビタミンB6'
      t.integer :vit_12, comment: 'ビタミンB12'
      t.integer :vit_c, comment: 'ビタミンC'
      t.integer :potassium, comment: 'カリウム'
      t.integer :calcium, comment: 'カルシウム'
      t.integer :magnesium, comment: 'マグネシウム'
      t.integer :phosphorus, comment: 'リン'
      t.integer :iron, comment: '鉄'
      t.integer :zinc, comment: '亜鉛'
      t.integer :copper, comment: '銅'
      t.integer :manganese, comment: 'マンガン'
      t.integer :beta_carotene, comment: 'βカロテン'
      t.integer :niacin, comment: 'ナイアシン'
      t.integer :folic_acid, comment: '葉酸'
      t.integer :pantothenic_acid, comment: 'パントテン酸'
      t.timestamps
    end
  end
end
