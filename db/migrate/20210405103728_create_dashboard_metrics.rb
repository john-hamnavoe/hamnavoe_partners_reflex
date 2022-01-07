class CreateDashboardMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :dashboard_metrics do |t|
      t.string :name
      t.string :title
      t.string :icon
      t.string :color
      t.integer :position

      t.timestamps
    end
  end
end
