class AddColumnProfileImageToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :profile_image, :string, after: :subscribed_at
  end
  def down
    remove_column :users, :profile_image, :string
  end
end
