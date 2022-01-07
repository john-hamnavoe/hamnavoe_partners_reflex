class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :domain
      t.boolean :restrict_to_domain, default: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
