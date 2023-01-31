class AddIndexToFavorite < ActiveRecord::Migration[6.1]
  def change
    add_index :favorites, [:cuisine_id, :user_id], unique: true
  end
end
