class AddDiscardedAtToCuisines < ActiveRecord::Migration[5.1]
  def change
    add_column :cuisines, :discarded_at, :datetime
    add_index :cuisines, :discarded_at
  end
end
