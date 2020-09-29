class AddDefaultServingCountToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :default_serving_count, :integer, default: 1, after: :email
  end
  def down
    remove_column :users, :default_serving_count, :integer
  end
end
