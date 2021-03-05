class RemoveAlignmentSequenceToProcedures < ActiveRecord::Migration[5.1]
  def up
    remove_column :procedures, :alignment_sequence
  end

  def down
    add_column :procedures, :alignment_sequence, :integer
  end
end
