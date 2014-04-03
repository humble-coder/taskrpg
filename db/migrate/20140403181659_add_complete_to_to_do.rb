class AddCompleteToToDo < ActiveRecord::Migration
  def change
  	add_column :to_dos, :complete, :boolean, :default => false
  end
end
