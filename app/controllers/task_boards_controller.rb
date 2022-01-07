# frozen_string_literal: true

class TaskBoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def show
    @task_board = repo.load(params[:id])
  end

  def index
    task_boards = repo.all({}, query_params, permitted_column_name(permitted_order_columns, session[session_symbol("order_by")]), permitted_direction(session[session_symbol("direction")]))
    @page, @pagy, @task_boards = pagy_results(task_boards)

    respond_to do |format|
      format.html
      format.json { render json: task_boards }
    end
  end

  def create
    @task_board = repo.create(task_board_params)
    if @task_board.valid?
      redirect_to task_boards_path
    else
      respond_to do |format|
        format.html { broadcast_errors @task_board, task_board_params }
        format.json { render json: @task_board.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task_board = repo.update(params[:id], task_board_params)
    render json: "Invalid", status: :unprocessable_entity and return unless @task_board

    if @task_board.valid?
      redirect_to task_boards_path
    else
      respond_to do |format|
        format.html { broadcast_errors @task_board, task_board_params }
        format.json { render json: @task_board.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_board_params
    params.require(:task_board).permit(:name, :software, :version, :is_active, :start_date, :end_date)
  end

  def permitted_order_columns
    %w[name software version start_date end_date owner]
  end

  def repo
    @repo ||= TaskBoardRepository.new(current_user)
  end
end
