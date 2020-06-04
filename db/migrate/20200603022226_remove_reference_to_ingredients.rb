class RemoveReferenceToIngredients < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :ingredients, column: :managers_id
    remove_column :ingredients, :managers_id, :integer
  end
end
