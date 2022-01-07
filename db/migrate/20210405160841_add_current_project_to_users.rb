class AddCurrentProjectToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :current_project, null: true, foreign_key: { to_table: :projects }
  end
end
