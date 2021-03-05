class RemoveDiscardedatToFoodcategories < ActiveRecord::Migration[5.1]
  def up
    remove_index :foodcategories, :discarded_at
    remove_column :foodcategories, :discarded_at
  end

  def down
    add_column :foodcategories, :discarded_at, :datetime
    add_index :foodcategories, :discarded_at
  end
end
