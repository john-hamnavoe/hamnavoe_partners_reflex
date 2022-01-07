# frozen_string_literal: true

require "test_helper"

class GridViewControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @grid_view = grid_views(:one)
  end

  test "should get index" do
    sign_in @bob
    get user_grid_views_path(@bob)
    assert_response :success
  end

  test "should not get index when not signed in" do
    get user_grid_views_path(@bob)
    assert_redirected_to new_user_session_path
  end

  test "should get edit" do
    sign_in @bob
    get edit_user_grid_view_path(@bob, @grid_view)
    assert_response :success
    grid_view = assigns(:grid_view)
    available_columns = assigns(:available_columns)
    assert_not grid_view.nil?
    assert_not available_columns.nil?
  end
end
