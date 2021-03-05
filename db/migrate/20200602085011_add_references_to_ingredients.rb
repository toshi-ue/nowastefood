class AddReferencesToIngredients < ActiveRecord::Migration[5.1]
  def up
    add_reference :ingredients, :managers, after: :name, foreign_key: true, comment: "管理者id"
  end

  def down
    remove_reference :ingredients, :managers, foreign_key: true, comment: "管理者id"
  end
end
