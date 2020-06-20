class AddUnitToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    add_reference :foodstuffs, :unit, index: true, foreign_key: true
  end

  def down
    remove_reference :foodstuffs, :unit, index: true, foreign_key: true
  end
end
