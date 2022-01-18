class AddColumnGenreToCuisines < ActiveRecord::Migration[6.0]
  def up
    add_column :cuisines, :genre, :integer, after: :user_id, null: false, default: 1
  end

  def down
    remove_column :cuisines, :genre, :integer
  end
end
