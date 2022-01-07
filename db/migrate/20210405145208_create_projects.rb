class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :software
      t.string :version
      t.date :start_date
      t.boolean :is_active, default: true
      t.date :end_date
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :organisation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
