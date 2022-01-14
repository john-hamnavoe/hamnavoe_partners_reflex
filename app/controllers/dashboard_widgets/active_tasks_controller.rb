# frozen_string_literal: true

class DashboardWidgets::ActiveTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def index
    tasks = repo.all({is_complete: false}, nil, "projects.name", "asc", false)
    summary = tasks.group("projects.name").count
    render partial: "dashboard_widgets/active_tasks/index", locals: { summary: summary }
  end

  private

  def repo
    @repo ||= TaskRepository.new(current_user)
  end
end
