class RemoveColumns2ToFoodcategory < ActiveRecord::Migration[5.1]
  def change
    remove_column :foodcategories, :applicant_id, :integer
    remove_column :foodcategories, :approver_id, :integer
  end
end
