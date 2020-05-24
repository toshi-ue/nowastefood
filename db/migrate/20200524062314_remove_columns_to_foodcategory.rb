class RemoveColumnsToFoodcategory < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :foodcategories, column: :approver_id
  end
end
