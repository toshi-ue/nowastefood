class RemoveColumnsToingredients < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :ingredients, :managers
    remove_reference :ingredients, :applicant, index: true
    remove_foreign_key :ingredients, :managers
    remove_reference :ingredients, :approver, index: true
  end

  def down
    add_references :applicant, index: true, foreign_key: { to_table: :managers }
    add_references :approver, index: true, foreign_key: { to_table: :managers }
  end
end
