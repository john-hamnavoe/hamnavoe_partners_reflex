class CreateGridViews < ActiveRecord::Migration[6.1]
  def change
    create_table :grid_views do |t|
      t.string :name
      t.references :grid, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
