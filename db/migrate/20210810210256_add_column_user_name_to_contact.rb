class AddColumnUserNameToContact < ActiveRecord::Migration[6.0]
  def up
    add_column :contacts, :user_name, :string, after: :category
  end

  def down
    remove_column :contacts, :user_name, :string
  end
end
