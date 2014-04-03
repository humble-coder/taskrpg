class RemoveCompleteFromToDo < ActiveRecord::Migration
  def change
  	remove_column :to_dos, :complete, :boolean
  end
end
