class AddColumnToManager < ActiveRecord::Migration[5.1]
  def change
    add_column :managers, :confirmation_token, :string
    add_column :managers, :confirmed_at, :datetime
    add_column :managers, :confirmation_sent_at, :datetime
    add_column :managers, :unconfirmed_email, :string

    add_column :managers, :
    add_column :managers, :
    add_column :managers, :
    add_column :managers, :
  end
end
