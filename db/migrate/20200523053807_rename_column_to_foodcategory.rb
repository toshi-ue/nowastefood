class RenameColumnToFoodcategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :foodcategories, :manager_id, :applicant_id
  end
end
