class DropProcedureimage < ActiveRecord::Migration[5.1]
  def change
    drop_table :procedureimages
  end
end
