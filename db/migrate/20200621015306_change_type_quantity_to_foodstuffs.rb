class ChangeTypeQuantityToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    change_column :foodstuffs, :quantity, :float, null: true
  end
  def down
    change_column :foodstuffs, :quantity, :integer, null: true
  end
end
