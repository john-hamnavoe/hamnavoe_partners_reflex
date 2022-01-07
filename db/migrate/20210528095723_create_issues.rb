class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :reference
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.boolean :is_archived
      t.integer :priority_id
      t.references :project, null: false, foreign_key: true
      t.references :organisation, null: false, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
