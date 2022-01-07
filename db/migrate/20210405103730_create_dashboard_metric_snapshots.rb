class CreateDashboardMetricSnapshots < ActiveRecord::Migration[6.1]
  def change
    create_table :dashboard_metric_snapshots do |t|
      t.references :organisation, null: false, foreign_key: true
      t.references :dashboard_metric, null: false, foreign_key: true
      t.date :date
      t.integer :value
      t.integer :last_value

      t.timestamps
    end
  end
end
