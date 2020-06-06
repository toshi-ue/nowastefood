class AddColumnToCookedstates < ActiveRecord::Migration[5.1]
  def change
    add_column :cookedstates, :discarded_at, :datetime, after: :name
    add_index :cookedstates, :discarded_at
  end
end
