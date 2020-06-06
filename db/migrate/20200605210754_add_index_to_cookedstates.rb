class AddIndexToCookedstates < ActiveRecord::Migration[5.1]
  def change
    change_column :cookedstates, :name, :string, index: true
  end
end
