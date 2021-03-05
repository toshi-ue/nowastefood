class RemoveForeignkeyToFoodcategory < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :foodcategories, column: :applicant_id
  end
end
