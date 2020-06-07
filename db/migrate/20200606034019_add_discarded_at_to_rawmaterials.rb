class AddDiscardedAtToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    add_column :rawmaterials, :discarded_at, :datetime, after: :name
    add_index :rawmaterials, :discarded_at
  end

  def down
    remove_index :rawmaterials, :discarded_at
    remove_column :rawmaterials, :discarded_at
  end
end
