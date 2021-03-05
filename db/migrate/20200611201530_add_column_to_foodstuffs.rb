class AddColumnToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    add_column :foodstuffs, :quantity, :integer, after: :id, comment: '数量'
  end

  def down
    remove_column :foodstuffs, :quantity
  end
end
