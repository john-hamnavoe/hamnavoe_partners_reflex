# frozen_string_literal: true

require "test_helper"

class GridViewColumnEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @column = columns(:three)
    @grid_view = grid_views(:one)
    @grid_view_column = grid_view_columns(:one)
  end

  test "should create grid view column" do
    sign_in @bob
    assert_difference "GridViewColumn.count", +1 do
      post user_grid_view_columns_path(@bob), params: { grid_view_column: { grid_view_id: @grid_view.id, column_id:  @column.id } }
    end
    grid_view_column = GridViewColumn.find_by(grid_view_id: @grid_view.id, column_id: @column.id)
    assert_equal 2, grid_view_column.position
  end

  test "should not create grid view column not signed in" do
    assert_no_difference "GridViewColumn.count" do
      post user_grid_view_columns_path(@bob), params: { grid_view_column: { grid_view_id: @grid_view.id, column_id:  @column.id } }
    end
  end

  test "should create entity grid view column and move to position 1" do
    sign_in @bob
    assert_difference "GridViewColumn.count", +1 do
      post user_grid_view_columns_path(@bob), params: { grid_view_column: { grid_view_id: @grid_view.id, column_id:  @column.id } }
    end
    grid_view_column = GridViewColumn.find_by(grid_view_id: @grid_view.id, column_id: @column.id)
    assert_equal 2, grid_view_column.position

    patch move_user_grid_view_column_path(@bob, grid_view_column), params: { position: 1 }
    grid_view_column.reload
    assert_equal 1, grid_view_column.position
    @grid_view_column.reload
    assert_equal 2, @grid_view_column.position
  end

  test "should destroy grid view column" do
    sign_in @bob
    assert_difference "GridViewColumn.count", -1 do
      delete user_grid_view_column_path(@bob, @grid_view_column)
    end
  end
end
