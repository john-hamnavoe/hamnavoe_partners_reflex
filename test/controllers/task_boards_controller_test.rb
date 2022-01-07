# frozen_string_literal: true

require "test_helper"

class TaskBoardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_board = task_boards(:one)
  end

  test "should get index" do
    sign_in @bob
    get task_boards_path
    assert_in_organisation(assigns(:task_boards), @bob.current_organisation)
    assert_in_project(assigns(:task_boards), @bob.current_project)
    assert_response :success
  end

  test "should not get index" do
    get task_boards_path
    assert_redirected_to new_user_session_path
  end
end
