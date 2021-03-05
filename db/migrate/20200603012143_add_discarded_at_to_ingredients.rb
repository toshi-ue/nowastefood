class AddDiscardedAtToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :discarded_at, :datetime
    add_index :ingredients, :discarded_at
  end
end
