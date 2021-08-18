class ChangeColumnCategoryToContact < ActiveRecord::Migration[6.0]
  def up
    change_column :contacts, :category, :integer, null: false, default: 0
  end

  def down
    change_column :contacts, :category, :string
  end
end
