class AddColumnCookdetailToProcedures < ActiveRecord::Migration[5.1]
  def up
    add_column :procedures, :cooking_detail, :string, after: :id
  end

  def down
    remove_column :procedures, :cooking_detail, :string
  end
end
