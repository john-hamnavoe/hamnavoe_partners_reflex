# frozen_string_literal: true

require "test_helper"

class TaskNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_list = task_lists(:one)
    @task = Task.new(title: "TaskNewTest", story_points: 3, description: "fuller description than name", task_list: @task_list)
  end

  test "should create task within organisation" do
    sign_in @bob
    assert_difference "Task.count", + 1 do
      post_task
    end
    assert_redirected_to task_board_path(@task_list.task_board)
    @saved_task = Task.find_by(title: "TaskNewTest")
    assert_save @task, @saved_task, %w[organisation_id project_id position], "Expect to save organisation and project set based on user"
    assert_organisation(@saved_task, @bob.current_organisation)
    assert_project(@saved_task, @bob.current_project)
  end

  test "should not create task within organisation" do
    sign_in @bob
    @task.title = "a" * 101
    assert_no_difference "Task.count" do
      post_task
    end
    assert_response :success
    task = assigns(:task)
    assert_not task.valid?
    @saved_task = Task.find_by(title: "a" * 101)
    assert_nil @saved_task
  end

  private

  def updated_fields
    %w[title story_points description]
  end

  def post_task
    post tasks_path, params: parameters_from_instance(@task)
  end
end
