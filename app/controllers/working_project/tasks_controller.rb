# frozen_string_literal: true

class WorkingProject::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!
  before_action :user_selected_project!

  def index
    tasks = repo.all({}, query_params, permitted_column_name(permitted_order_columns, session[session_symbol("order_by")]), permitted_direction(session[session_symbol("direction")]))
    @page, @pagy, @tasks = pagy_results(tasks)

    respond_to do |format|
      format.html
      format.json { render json: tasks }
    end
  end

  private

  def permitted_order_columns
    %w[title story_points due_date position is_complete is_billable]
  end

  def repo
    @repo ||= TaskRepository.new(current_user)
  end
end
