# frozen_string_literal: true

require "test_helper"

class TaskBoardEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_board = task_boards(:one)
    update_task_board
  end

  test "should update task_board within organisation" do
    sign_in @bob
    assert_no_difference "TaskBoard.count" do
      put_task_board
    end
    assert_redirected_to task_boards_path
    @saved_task_board = TaskBoard.find_by(id: @task_board.id)
    assert_save @task_board, @saved_task_board
  end

  test "should not update task_board within organisation" do
    sign_in @bob
    @task_board.name = "a" * 51
    assert_no_difference "TaskBoard.count" do
      put_task_board
    end
    assert_response :success
    task_board = assigns(:task_board)
    assert_not task_board.valid?
    @saved_task_board = TaskBoard.find_by(id: @task_board.id)
    assert_no_save @task_board, @saved_task_board, updated_fields
  end

  test "should not update task_board within organisation when not logged in" do
    assert_no_difference "TaskBoard.count" do
      put_task_board
    end
    assert_redirected_to new_user_session_path
    @saved_task_board = TaskBoard.find_by(id: @task_board.id)
    assert_no_save @task_board, @saved_task_board, updated_fields
  end

  test "should not update task_board in other organisation" do
    @task_board = task_boards(:two)
    update_task_board
    sign_in @bob
    assert_no_difference "TaskBoard.count" do
      put_task_board
    end
    assert_response :unprocessable_entity
    @saved_task_board = TaskBoard.find_by(id: @task_board.id)
    assert_no_save @task_board, @saved_task_board, updated_fields
  end

  private

  def updated_fields
    %w[name is_active]
  end

  def update_task_board
    @task_board.is_active = !@task_board.is_active
    @task_board.name = "updated name"
  end

  def put_task_board
    put task_board_path(@task_board), params: parameters_from_instance(@task_board)
  end
end
