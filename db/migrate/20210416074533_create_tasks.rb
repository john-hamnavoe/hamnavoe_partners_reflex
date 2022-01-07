class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :task_list, null: false, foreign_key: true
      t.references :organisation, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :assigned_to, null: true, foreign_key: { to_table: :users }
      t.string :color
      t.string :title
      t.string :description
      t.integer :story_points
      t.integer :position
      t.boolean :is_complete
      t.boolean :is_billable
      t.boolean :is_archived
      t.date :due_date

      t.timestamps
    end
  end
end
