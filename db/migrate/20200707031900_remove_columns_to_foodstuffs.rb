class RemoveColumnsToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    remove_index :foodstuffs, :ingredient_id
    remove_index :foodstuffs, :cookedstate_id
    remove_column :foodstuffs, :ingredient_id
    remove_column :foodstuffs, :cookedstate_id
  end

  def down
    add_column :foodstuffs, :ingrediet_id, :integer, after: :cuisine_id
    add_column :foodstuffs, :cookedstate_id, :integer, after: :ingredient_id
    add_index :foodstuffs, :ingredient_id
    add_index :foodstuffs, :cookedstate_id
  end
end
