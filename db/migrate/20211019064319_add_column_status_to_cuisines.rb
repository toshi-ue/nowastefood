class AddColumnStatusToCuisines < ActiveRecord::Migration[6.0]
  def up
    add_column :cuisines, :status, :integer, default: 0, null: false, after: :user_id
  end

  def down
    remove_column :cuisines, :status, :integer
  end
end
