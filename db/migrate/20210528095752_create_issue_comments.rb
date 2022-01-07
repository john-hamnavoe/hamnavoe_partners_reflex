class CreateIssueComments < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
