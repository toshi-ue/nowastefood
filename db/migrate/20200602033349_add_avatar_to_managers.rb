class AddAvatarToManagers < ActiveRecord::Migration[5.1]
  def change
    change_table :managers, bulk: true do |t|
      t.string :name, after: :id
      t.string :avatar
    end
  end
end
