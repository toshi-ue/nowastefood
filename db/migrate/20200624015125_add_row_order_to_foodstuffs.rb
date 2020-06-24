class AddRowOrderToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    add_column :foodstuffs, :row_order, :integer, after: :cookedstate_id
  end

  def down
    remove_column :foodstuffs, :row_order
  end
end
