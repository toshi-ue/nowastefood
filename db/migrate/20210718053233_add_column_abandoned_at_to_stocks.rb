class AddColumnAbandonedAtToStocks < ActiveRecord::Migration[6.0]
  def up
    add_column :stocks, :abandoned_at, :boolean, after: :consumed_at
  end
  def down
    remove_column :stocks, :abandoned_at, :boolean
  end
end
