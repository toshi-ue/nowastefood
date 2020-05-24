class AddColumnToFoodcategory2 < ActiveRecord::Migration[5.1]
  def change
    add_reference :foodcategories, :manager, index: true, foreign_key: true
  end
end
