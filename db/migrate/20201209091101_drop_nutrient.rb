class DropNutrient < ActiveRecord::Migration[5.1]
  def change
    drop_table :nutrients
  end
end
