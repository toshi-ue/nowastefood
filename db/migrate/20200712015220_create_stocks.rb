class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :quantity, null: false
      t.references :rawmaterial, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
