class RemoveDiscardedAtToCuisines < ActiveRecord::Migration[5.1]
  def up
    remove_index :cuisines, :discarded_at
    remove_column :cuisines, :discarded_at
  end

  def down
    add_column :cuisines, :discarded_at, :datetime
    add_index :cuisines, :discarded_at
  end
end
