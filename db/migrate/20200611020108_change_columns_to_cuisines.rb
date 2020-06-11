class ChangeColumnsToCuisines < ActiveRecord::Migration[5.1]
  def up
    change_column :cuisines, :cooking_time, :integer, comment: '調理時間'
    add_column :cuisines, :difficulty, :integer, after: :name, default: 0, null: false, limit: 1, comment: "料理の難易度(enumで、低・中・高)"
  end

  def down
    remove_column :cuisines, :difficulty, :integer
    change_column :cuisines, :cooking_time, :integer, comment: 'お手軽度, (enumで、低、中・高)'
  end
end
