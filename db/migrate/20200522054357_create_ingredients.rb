  def change
    create_table :ingredients do |t|
      t.string :name, null: false, comment: "部位の名称"
      t.references :applicant, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.references :approver, index: true, foreign_key: { to_table: :managers }, comment: "承認した人のid(管理者id)"
      t.timestamps
    end
  end
