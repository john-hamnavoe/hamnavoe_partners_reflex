class AddCurrentOrganisationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :current_organisation, null: true, foreign_key: { to_table: :organisations }
  end
end
