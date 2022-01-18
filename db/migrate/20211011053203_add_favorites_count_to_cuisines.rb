class AddFavoritesCountToCuisines < ActiveRecord::Migration[6.0]
  def self.up
    add_column :cuisines, :favorites_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :cuisines, :favorites_count
  end
end
