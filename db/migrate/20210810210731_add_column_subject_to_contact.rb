class AddColumnSubjectToContact < ActiveRecord::Migration[6.0]
  def up
    add_column :contacts, :subject, :string, after: :user_name
  end

  def down
    remove_column :contacts, :subject, :string
  end
end
