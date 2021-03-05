class DropTableSubscriptions < ActiveRecord::Migration[5.1]
  def up
    drop_table :subscriptions
  end

  def down
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.integer :amount
      t.string :stripe_customer_id
      t.string :stripe_subscription_id

      t.timestamps
    end
  end
end
