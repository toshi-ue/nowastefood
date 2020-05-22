class CreateCookinghistories < ActiveRecord::Migration[5.1]
  def change
    create_table :cookinghistories do |t|
      t.references :cuisine, add_index: true, foregin_key: true, comment: '料理id'
      t.references :user, add_index: true, foregin_key: true, comment: 'ユーザーid'
      t.timestamps
    end
  end
end
