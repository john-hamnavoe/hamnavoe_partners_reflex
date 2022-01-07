class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :name
      t.string :label
      t.boolean :sortable
      t.boolean :default_on
      t.integer :default_position
      t.string :field
      t.string :object_1
      t.string :object_2
      t.references :grid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
