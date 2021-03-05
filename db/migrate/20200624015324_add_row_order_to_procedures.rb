class AddRowOrderToProcedures < ActiveRecord::Migration[5.1]
  def up
    add_column :procedures, :row_order, :integer, after: :cuisine_id
  end

  def down
    remove_column :procedures, :row_order
  end
end
