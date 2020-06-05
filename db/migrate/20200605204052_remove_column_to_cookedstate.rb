class RemoveColumnToCookedstate < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :cookedstates, column: :applicant_id
    remove_column :cookedstates, :applicant_id, :integer
  end
end
