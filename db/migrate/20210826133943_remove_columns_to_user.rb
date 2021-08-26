class RemoveColumnsToUser < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :subscribed, :boolean
    remove_column :users, :subscribed_at, :datetime
  end

  def down
    add_column :users, :subscribed, :boolean
    add_column :users, :subscribed_at, :datetime
  end
end
