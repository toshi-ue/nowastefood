class AddStripeColumnsToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :stripe_customer_id, :string, after: :default_serving_count
    add_column :users, :stripe_card_id, :string, after: :stripe_customer_id
    add_column :users, :subscribed, :boolean, after: :stripe_card_id
    add_column :users, :subscribed_at, :datetime, after: :subscribed
  end

  def down
    remove_column :users, :stripe_customer_id, :string
    remove_column :users, :stripe_card_id, :string
    remove_column :users, :subscribed, :boolean
    remove_column :users, :subscribed_at, :datetime
  end
end
