class CreateContacts < ActiveRecord::Migration[6.0]
  def up
    create_table :contacts do |t|
      t.string :category
      t.string :message

      t.timestamps
    end
  end

  def down
    create_table :contacts
  end
end
