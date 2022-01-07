class CreateOrganisationMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :organisation_memberships do |t|
      t.references :organisation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :is_admin

      t.timestamps
    end
  end
end
