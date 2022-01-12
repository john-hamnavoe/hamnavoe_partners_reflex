# frozen_string_literal: true

class TaskListsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!
  before_action :user_selected_project!

  def create
    @task_list = repo.create(task_list_params)
    if @task_list.valid?
      redirect_to task_board_path(@task_list.task_board)
    else
      broadcast_errors @task_list, task_list_params
    end
  end

  def move
    @task_list = TaskList.find(params[:task_list_id])
    @task_list.position = params[:position]
    @task_list.save
  end

  private

  def task_list_params
    params.require(:task_list).permit(:name, :task_board_id)
  end

  def repo
    @repo ||= TaskListRepository.new(current_user)
  end
end
