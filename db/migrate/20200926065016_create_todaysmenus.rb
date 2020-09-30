class CreateTodaysmenus < ActiveRecord::Migration[5.1]
  def change
    create_table :todaysmenus do |t|
      t.references :cuisine, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :serving_count

      t.timestamps
    end
  end
end
