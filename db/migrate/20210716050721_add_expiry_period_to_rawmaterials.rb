class AddExpiryPeriodToRawmaterials < ActiveRecord::Migration[6.0]
  def up
    add_column :rawmaterials, :expiry_period, :integer, null: false, default: 1, after: :foodcategory_id
  end

  def down
    remove_column :rawmaterials, :expiry_period, :integer
  end
end
