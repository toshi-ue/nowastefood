class ChangeTypeQuantityToFoodstuffs2 < ActiveRecord::Migration[5.1]
  def up
    change_column :foodstuffs, :quantity, :string, null: true
  end

  def down
    change_column :foodstuffs, :quantity, :float, null: true
  end
end
