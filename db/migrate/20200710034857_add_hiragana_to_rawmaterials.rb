class AddHiraganaToRawmaterials < ActiveRecord::Migration[5.1]
  def up
    remove_index :rawmaterials, :discarded_at
    remove_column :rawmaterials, :discarded_at, :datetime
    add_column :rawmaterials, :hiragana, :string, after: :name
  end

  def down
    add_column :rawmaterials, :discarded_at, :datetime
    add_index :rawmaterials, :discarded_at
    remove_column :rawmaterials, :hiragana, :string
  end
end
