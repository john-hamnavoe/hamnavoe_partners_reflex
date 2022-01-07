# frozen_string_literal: true

require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @project = projects(:one)
    @other_org_project = projects(:two)
  end

  test "should get index" do
    sign_in @bob
    get projects_path
    assert_response :success
  end

  test "should not get index" do
    get projects_path
    assert_redirected_to new_user_session_path
  end

  test "should get edit" do
    sign_in @bob
    get edit_project_path(@project)
    assert_response :success
  end

  test "should not get edit" do
    get edit_project_path(@project)
    assert_redirected_to new_user_session_path
  end

  test "should not get edit for wrong org" do
    sign_in @bob
    get edit_project_path(@other_org_project)
    assert_redirected_to projects_path
  end

  test "should get new" do
    sign_in @bob
    get new_project_path
    assert_response :success
  end

  test "should not get new" do
    get new_project_path
    assert_redirected_to new_user_session_path
  end
end
