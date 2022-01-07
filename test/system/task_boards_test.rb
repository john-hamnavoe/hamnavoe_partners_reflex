require "application_system_test_case"

class TaskBoardsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @task_board = task_boards(:one)
    sign_in @bob
  end

  test "visiting the index and adding new board" do
    visit task_boards_path

    assert_selector "h1", text: "TASK BOARDS"

    click_on "New"

    fill_in "Name", with: "My New Board"

    click_on "Save"

    assert_text "My New Board", count: 1
  end

  test "visiting the index and cancelling new board" do
    visit task_boards_path

    assert_selector "h1", text: "TASK BOARDS"

    click_on "New"

    assert_text "Task Board", count: 1

    fill_in "Name", with: "My New Board"

    click_on "Cancel"

    assert_text "My New Board", count: 0
    assert_text "Task Board", count: 0
  end

  test "visiting the index and editing a board" do
    visit task_boards_path

    assert_selector "h1", text: "TASK BOARDS"

    click_on "edit_#{@task_board.id}"

    fill_in "Name", with: "My New Board Name"

    click_on "Save"

    assert_text "My New Board Name", count: 1
  end

  test "visiting the index and editing a board and cancelling" do
    visit task_boards_path

    assert_selector "h1", text: "TASK BOARDS"

    click_on "edit_#{@task_board.id}"

    fill_in "Name", with: "My New Board Name"

    click_on "Cancel"

    assert_text "My New Board Name", count: 0
  end

  test "searching the index" do
    visit task_boards_path

    assert_text "2 results", count: 1

    fill_in "search-input", with: "Board 2"

    assert_text "1 result", count: 1
  end
end
