class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.text :name
      t.integer :priority

      t.timestamps
    end
  end
end
