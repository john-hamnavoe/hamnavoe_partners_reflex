# frozen_string_literal: true

require "test_helper"

class Users::CurrentProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @project = projects(:one)
    @change_project = projects(:three)
    @other_org_project = projects(:two)
  end

  test "should change project" do
    sign_in @bob
    put users_current_project_path(@change_project), headers: { "HTTP_REFERER" => "/task_boards" }
    assert_equal @change_project, @bob.current_project
    assert_redirected_to dashboard_index_path
  end

  test "should not change project when not logged in" do
    put users_current_project_path(@project)
    assert_equal @project, @bob.current_project
  end

  test "should not change project to other org project" do
    sign_in @bob
    put users_current_project_path(@other_org_project), headers: { "HTTP_REFERER" => "/task_boards" }
    assert_equal @project, @bob.current_project
  end
end
