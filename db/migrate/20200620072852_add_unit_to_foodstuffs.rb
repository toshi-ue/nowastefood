class AddUnitToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    add_reference :foodstuffs, :unit, index: true, foreign_key: true, after: :quantity, comment: "単位id"
  end

  def down
    remove_reference :foodstuffs, :unit, index: true, foreign_key: true
  end
end
