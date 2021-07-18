class AddColumnRottedAtToStocks < ActiveRecord::Migration[6.0]
  def up
    add_column :stocks, :rotted_at, :date, null: false, default: Time.zone.now, after: :user_id
  end

  def down
    remove_column :stocks, :rotted_at, :date
  end
end
