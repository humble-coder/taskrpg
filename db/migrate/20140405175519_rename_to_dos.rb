class RenameToDos < ActiveRecord::Migration
  def change
  	rename_table :to_dos, :tasks
  end
end
