class DropCookedstate < ActiveRecord::Migration[5.1]
  def change
    drop_table :cookedstates
  end
end
