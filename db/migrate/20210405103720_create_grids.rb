class CreateGrids < ActiveRecord::Migration[6.1]
  def change
    create_table :grids do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
  end
end
