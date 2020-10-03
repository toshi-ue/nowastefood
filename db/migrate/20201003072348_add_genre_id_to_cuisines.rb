class AddGenreIdToCuisines < ActiveRecord::Migration[5.1]
  def up
    add_reference :cuisines, :genre, foreign_key: true, after: :name
  end
  def down
    remove_reference :cuisines, :genre, foreign_key: true
  end
end
