# frozen_string_literal: true

class DashboardWidgets::ActiveIssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def index
    issues = repo.all({ is_archived: false }, nil, "projects.name", "asc", false)
    summary = issues.group("projects.name").count
    render partial: "dashboard_widgets/active_issues/index", locals: { summary: summary }
  end

  private

  def repo
    @repo ||= IssueRepository.new(current_user)
  end
end
