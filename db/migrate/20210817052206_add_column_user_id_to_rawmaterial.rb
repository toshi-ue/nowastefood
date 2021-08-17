class AddColumnUserIdToRawmaterial < ActiveRecord::Migration[6.0]
  def up
    add_reference :rawmaterials, :user, foreign_key: true, after: :hiragana
  end

  def down
    remove_reference :rawmaterials, :user, foreign_key: true
  end
end
