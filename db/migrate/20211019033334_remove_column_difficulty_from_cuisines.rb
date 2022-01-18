class RemoveColumnDifficultyFromCuisines < ActiveRecord::Migration[6.0]
  def up
    remove_column :cuisines, :difficulty, :integer
  end

  def down
    add_column :cuisines, :difficulty, :integer, after: :name, default: 0, null: false, limit: 1, comment: "料理の難易度(enumで、低・中・高)"
  end
end
