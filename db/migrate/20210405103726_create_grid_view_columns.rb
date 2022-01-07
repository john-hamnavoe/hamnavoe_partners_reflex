class CreateGridViewColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :grid_view_columns do |t|
      t.references :grid_view, null: false, foreign_key: true
      t.references :column, null: false, foreign_key: true
      t.string :label
      t.integer :position

      t.timestamps
    end
  end
end
