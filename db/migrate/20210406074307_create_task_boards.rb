class CreateTaskBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :task_boards do |t|
      t.string :name
      t.boolean :is_active, default: true
      t.references :organisation, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
