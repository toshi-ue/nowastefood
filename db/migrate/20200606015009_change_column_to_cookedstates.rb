class ChangeColumnToCookedstates < ActiveRecord::Migration[5.1]
  def up
    add_index :cookedstates, :name, unique: true
  end

  def dowm
    remove_index :cookedstates, :name, unique: true
  end
end
