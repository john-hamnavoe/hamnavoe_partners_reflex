class CreateTaskLists < ActiveRecord::Migration[6.1]
  def change
    create_table :task_lists do |t|
      t.references :task_board, null: false, foreign_key: true
      t.references :organisation, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.boolean :is_active, default: true
      t.string :name
      t.integer :position
      t.string :color

      t.timestamps
    end
  end
end
