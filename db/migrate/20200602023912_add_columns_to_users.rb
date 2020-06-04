class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :avatar
    end
  end
end
