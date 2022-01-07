# frozen_string_literal: true

require "test_helper"

class GridViewDeleteTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @grid_view = grid_views(:one)
  end

  test "should remove grid view" do
    sign_in @bob

    assert_difference "GridView.count", -1 do
      delete user_grid_view_path(@bob, @grid_view)
    end

    assert_redirected_to grid_views_path
  end

  test "should not remove grid view if not signed in " do
    assert_no_difference "GridView.count" do
      delete user_grid_view_path(@bob, @grid_view)
    end

    assert_redirected_to new_user_session_path
  end
end
