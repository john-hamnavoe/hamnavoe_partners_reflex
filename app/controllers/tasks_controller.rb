# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!
  before_action :user_selected_project!

  def create
    @task = repo.create(task_params)
    if @task.valid?
      head :no_content
    else
      broadcast_errors @task, task_params
    end
  end

  def update
    @task = repo.update(params[:id], task_params)

    if @task.valid?
      head :no_content
    else
      broadcast_errors @task, task_params
    end
  end

  def move
    @task = Task.find(params[:task_id])
    to_list = params[:to_list_id]
    @task.task_list_id = to_list
    @task.position = params[:position]
    @task.save
  end

  private

  def task_params
    params.require(:task).permit(:title, :task_list_id, :assigned_to_id, :description, :color, :story_points, :position, :due_date, :is_complete, :is_billable, :is_archived)
  end

  def repo
    @repo ||= TaskRepository.new(current_user)
  end
end
