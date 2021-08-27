class RemoveColumnsAbandonedAtToStock < ActiveRecord::Migration[6.0]
  def up
    remove_column :stocks, :abandoned_at, :boolean
  end

  def down
    add_column :stocks, :abandoned_at, :boolean
  end
end
