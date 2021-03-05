class AddFoodcategoryIdToCookedstates < ActiveRecord::Migration[5.1]
  def up
    add_reference :cookedstates, :foodcategory, foreign_key: true, after: :name
  end

  def down
    remove_reference :cookedstates, :foodcategory, foreign_key: true
  end
end
