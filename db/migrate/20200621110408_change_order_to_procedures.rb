class ChangeOrderToProcedures < ActiveRecord::Migration[5.1]
  def up
    rename_column :procedures, :order, :alignment_sequence
  end

  def down
    rename_column :procedures, :alignment_sequence, :order
  end
end
