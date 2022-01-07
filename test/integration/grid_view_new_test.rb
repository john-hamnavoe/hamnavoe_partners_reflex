# frozen_string_literal: true

require "test_helper"

class GridViewNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @grid_view = grid_views(:one)
    @grid = grids(:two)
  end

  test "create new grid view for grid" do
    sign_in @bob

    assert_difference "GridView.count", +1 do
      post user_grid_views_path(@bob), params: { grid_id: @grid.id }
    end
    grid_view = assigns(:grid_view)
    assert_redirected_to edit_user_grid_view_path(@bob.id, grid_view.id)
  end

  test "should not create new grid view for grid not signed in" do
    assert_no_difference "GridView.count" do
      post user_grid_views_path(@bob), params: { grid_id: @grid.id }
    end
    assert_redirected_to new_user_session_path
  end

  test "should not create new grid view for grid already with view" do
    sign_in @bob

    assert_no_difference "GridView.count" do
      post user_grid_views_path(@bob), params: { grid_id: @grid_view.grid_id }
    end
    assert_redirected_to edit_user_grid_view_path(@bob.id, @grid_view.id)
  end
end
