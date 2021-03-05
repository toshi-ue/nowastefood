class RemoveIndexToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :rawmaterials, column: :applicant_id
    remove_foreign_key :rawmaterials, column: :approver_id
    remove_column :rawmaterials, :applicant_id, :integer
    remove_column :rawmaterials, :approver_id, :integer
  end

  def down
    add_reference :rawmaterials, :applicant, foreign_key: { to_table: :managers }
    add_reference :rawmaterials, :approver, foreign_key: { to_table: :managers }
  end
end
