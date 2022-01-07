# frozen_string_literal: true

require "test_helper"

class TaskListNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_board = task_boards(:one)
    @task_list = TaskList.new(name: "TaskListNewTest", is_active: true, task_board: @task_board)
  end

  test "should create task_list within organisation" do
    sign_in @bob
    assert_difference "TaskList.count", + 1 do
      post_task_list
    end
    assert_redirected_to task_board_path(@task_board)
    @saved_task_list = TaskList.find_by(name: "TaskListNewTest")
    assert_save @task_list, @saved_task_list, %w[organisation_id project_id position], "Expect to save organisation and project set based on user"
    assert_organisation(@saved_task_list, @bob.current_organisation)
    assert_project(@saved_task_list, @bob.current_project)
  end

  test "should not create task_list within organisation" do
    sign_in @bob
    @task_list.name = "a" * 51
    assert_no_difference "TaskList.count" do
      post_task_list
    end
    assert_response :success
    task_list = assigns(:task_list)
    assert_not task_list.valid?
    @saved_task_list = TaskList.find_by(name: "a" * 51)
    assert_nil @saved_task_list
  end

  private

  def updated_fields
    %w[name is_active]
  end

  def post_task_list
    post task_lists_path, params: parameters_from_instance(@task_list)
  end
end
