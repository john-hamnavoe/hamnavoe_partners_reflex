# frozen_string_literal: true

class DashboardMetricSnapshotRepository < ApplicationRepository
  def all(_args = {}, _params = nil)
    default_metrics
    DashboardMetricSnapshot.joins(:dashboard_metric).where(organisation: organisation, date: Time.zone.today).order("dashboard_metrics.position")
  end

  private

  def default_metrics
    dashboard_metrics = DashboardMetric.all
    dashboard_metrics.each do |dm|
      snapshot = DashboardMetricSnapshot.find_or_create_by(organisation: organisation, dashboard_metric_id: dm.id, date: Time.zone.today)
      snapshot.update(value: 0, last_value: 0) if snapshot.value.nil?
    end
  end
end
