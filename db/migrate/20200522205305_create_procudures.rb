class CreateProcudures < ActiveRecord::Migration[5.1]
  def change
    create_table :procudures do |t|
      t.string :order, null: false, comment: "æé "
      t.references :cuisine, add_index: true, foregin_key: true, comment: 'æçid'
      t.timestamps
    end
  end
end
