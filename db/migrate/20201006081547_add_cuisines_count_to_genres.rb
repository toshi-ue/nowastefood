class AddCuisinesCountToGenres < ActiveRecord::Migration[5.1]
  def self.up
    add_column :genres, :cuisines_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :genres, :cuisines_count
  end
end
