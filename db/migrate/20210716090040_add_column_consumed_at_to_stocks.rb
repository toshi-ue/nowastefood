class AddColumnConsumedAtToStocks < ActiveRecord::Migration[6.0]
  def up
    add_column :stocks, :consumed_at, :datetime, after: :rotted_at
  end

  def down
    remove_column :stocks, :consumed_at, :datetime
  end
end
