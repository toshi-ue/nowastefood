class RemoveManagerIdToIngredients < ActiveRecord::Migration[5.1]
  def up
    remove_reference :ingredients, :manager, index: true, foreign_key: true
  end

  def down
    add_reference :ingredients, :manager, index: true, foreign_key: true, after: :id
  end
end
