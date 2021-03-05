class RemoveMeasureUnitToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    remove_column :foodstuffs, :measure_unit
  end

  def down
    add_column :foodstuffs, :measure_unit, :integer, after: :quantity
  end
end
