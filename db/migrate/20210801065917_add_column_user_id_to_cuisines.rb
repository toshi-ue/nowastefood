class AddColumnUserIdToCuisines < ActiveRecord::Migration[6.0]
  def up
    add_reference :cuisines, :user, foreign_key: true, after: :id
  end

  def down
    remove_reference :cuisines, :user, foreign_key: true
  end
end
