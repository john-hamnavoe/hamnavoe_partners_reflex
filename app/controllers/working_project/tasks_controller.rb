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

  def update
    @task = repo.update(params[:id], task_params)

    if @task.valid?
      redirect_to working_project_tasks_path
    else
      respond_to do |format|
        format.html { broadcast_errors @task, task_params }
        format.json { render json: @task.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :task_list_id, :description, :color, :story_points, :position, :due_date, :is_complete, :is_billable, :is_archived)
  end

  def permitted_order_columns
    %w[title story_points due_date position is_complete is_billable]
  end

  def repo
    @repo ||= TaskRepository.new(current_user)
  end
end
