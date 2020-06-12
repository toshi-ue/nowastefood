class RemoveCookingTimeToFoodstuffs < ActiveRecord::Migration[5.1]
  def up
    remove_column :foodstuffs, :cooking_time
  end

  def down
    add_column :foodstuffs, :cooking_time, :integer, after: :id, comment: '料理時間'
  end
end
