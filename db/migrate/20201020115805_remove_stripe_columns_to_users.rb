class RemoveStripeColumnsToUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :stripe_customer_id, :string
    remove_column :users, :stripe_card_id, :string
  end
  def down
    add_column :users, :stripe_customer_id, :string, after: :default_serving_count
    add_column :users, :stripe_card_id, :string, after: :stripe_customer_id
  end
end
