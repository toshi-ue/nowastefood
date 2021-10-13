class DropTableGenres < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :cuisines, :genres
    remove_reference :cuisines, :genre, index: true
    drop_table :genres
  end
end
