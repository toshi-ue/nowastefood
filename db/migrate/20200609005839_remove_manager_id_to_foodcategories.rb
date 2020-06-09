class RemoveManagerIdToFoodcategories < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :foodcategories, column: :manager_id
    # remove_index :foodcategories, :manager
    remove_column :foodcategories, :manager_id
  end

  def down
    add_reference :foodcategories, :manager, foreign_key: true
  end
end
