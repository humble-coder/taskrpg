class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :value
      t.references :user, index: true

      t.timestamps
    end
  end
end
