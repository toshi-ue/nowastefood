class RenameTableFromProcuduresToProcedures < ActiveRecord::Migration[5.1]
  def up
    rename_table :procudures, :procedures
  end

  def down
    rename_table :procedures, :procudures
  end
end
