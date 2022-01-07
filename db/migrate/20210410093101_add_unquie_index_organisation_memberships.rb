class AddUnquieIndexOrganisationMemberships < ActiveRecord::Migration[6.1]
  def change
    add_index :organisation_memberships, [:organisation_id, :user_id], unique: true
  end
end
