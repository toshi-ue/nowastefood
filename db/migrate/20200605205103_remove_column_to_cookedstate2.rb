class RemoveColumnToCookedstate2 < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :cookedstates, column: :approver_id
    remove_column :cookedstates, :approver_id, :integer
  end
end
