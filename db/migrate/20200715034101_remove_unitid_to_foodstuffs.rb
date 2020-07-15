class RemoveUnitidToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    remove_reference :foodstuffs, :unit, foreign_key: true
  end

  def down
    add_reference :foodstuffs, :unit, foreign_key: true
  end
end
