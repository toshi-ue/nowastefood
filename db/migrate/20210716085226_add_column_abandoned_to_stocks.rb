class AddColumnAbandonedToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :abandoned, :boolean, null: false, defalut: 0, after: :rotted_at
  end

  def down
    remove_column :stocks, :abandoned, :boolean, null: true, defalut: 0,
  end
end
