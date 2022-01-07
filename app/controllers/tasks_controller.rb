# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def create
    @task = repo.create(task_params)
    if @task.valid?
      redirect_to task_board_path(@task.task_list.task_board)
    else
      respond_to do |format|
        format.html { broadcast_errors @task, task_params }
        format.json { render json: @task.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = repo.update(params[:id], task_params)
    if @task.valid?
      redirect_to task_board_path(@task.task_list.task_board)
    else
      respond_to do |format|
        format.html { broadcast_errors @task, task_params }
        format.json { render json: @task.errors.to_json, status: :unprocessable_entity }
      end
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
    params.require(:task).permit(:title, :task_list_id, :description, :color, :story_points, :position, :due_date, :is_complete, :is_billable, :is_archived)
  end

  def repo
    @repo ||= TaskRepository.new(current_user)
  end
end
