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
      respond_to do |format|
        format.html { broadcast_errors @task_list, task_list_params }
        format.json { render json: @task_list.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def move
    @task_list = TaskList.find(params[:task_list_id])
    @task_list.position = params[:position]
    @task_list.save

    # sleep(5)
    # cable_ready["morph"].morph(
    #   selector: dom_id(@task_list.task_board) + "_show",
    #   html: "<div>Blow Me</div>"
    # )
    # cable_ready.broadcast
  end

  private

  def task_list_params
    params.require(:task_list).permit(:name, :task_board_id)
  end

  def repo
    @repo ||= TaskListRepository.new(current_user)
  end
end
