class ChangeAlignmentSequenceToProcedures < ActiveRecord::Migration[5.1]
  def up
    change_column :procedures, :alignment_sequence, :integer
  end

  def down
    change_column :procedures, :alignment_sequence, :string
  end
end
