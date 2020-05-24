class AddDiscardedAtToFoodcategories < ActiveRecord::Migration[5.1]
  def change
    add_column :foodcategories, :discarded_at, :datetime
    add_index :foodcategories, :discarded_at
  end
end
