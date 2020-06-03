class AddColumnToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_reference :ingredients, :manager, foreign_key: true, after: :id
  end
end
