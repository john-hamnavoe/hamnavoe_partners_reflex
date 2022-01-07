# frozen_string_literal: true

require "test_helper"

class TaskBoardNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_board = TaskBoard.new(name: "TaskBoardNewTest", is_active: true)
  end

  test "should create task_board within organisation" do
    sign_in @bob
    assert_difference "TaskBoard.count", + 1 do
      post_task_board
    end
    assert_redirected_to task_boards_path
    @saved_task_board = TaskBoard.find_by(name: "TaskBoardNewTest")
    assert_save @task_board, @saved_task_board, %w[organisation_id project_id owner_id], "Expect to save and owner, organisation and project set based on user"
    assert_organisation(@saved_task_board, @bob.current_organisation)
    assert_project(@saved_task_board, @bob.current_project)
  end

  test "should not create task_board within organisation" do
    sign_in @bob
    @task_board.name = "a" * 51
    assert_no_difference "TaskBoard.count" do
      post_task_board
    end
    assert_response :success
    task_board = assigns(:task_board)
    assert_not task_board.valid?
    @saved_task_board = TaskBoard.find_by(name: "a" * 51)
    assert_nil @saved_task_board
  end

  private

  def updated_fields
    %w[name is_active]
  end

  def post_task_board
    post task_boards_path, params: parameters_from_instance(@task_board)
  end
end
