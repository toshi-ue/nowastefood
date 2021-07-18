class RemoveColumnAbandonedFromStocks < ActiveRecord::Migration[6.0]
  def up
    remove_column :stocks, :abandoned
  end

  def down
    add_column :stocks, :abandoned, :boolean
  end
end
