# frozen_string_literal: true

require "test_helper"

class TaskBoardTest < ActiveSupport::TestCase
  def setup
    @task_board = TaskBoard.new(name: "new", project: projects(:one), organisation: organisations(:one), owner: users(:one))
  end

  test "the validation" do
    assert @task_board.valid?
  end

  test "name validation" do
    @task_board.name = "a" * 51
    assert_not @task_board.valid?
  end

  test "project validation" do
    @task_board.project = nil
    assert_not @task_board.valid?
  end

  test "organisation validation" do
    @task_board.organisation = nil
    assert_not @task_board.valid?
  end

  test "owner validation" do
    @task_board.owner = nil
    assert_not @task_board.valid?
  end
end
