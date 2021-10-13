class AddColumnGenreToCuisines < ActiveRecord::Migration[6.0]
  def up
    add_column :cuisines, :genre, :integer, after: :user_id
    add_index :cuisines, :genre
  end

  def down
    remove_index :cuisines, :genre
    remove_column :cuisines, :genre, :integer
  end
end
