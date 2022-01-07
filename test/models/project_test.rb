# frozen_string_literal: true

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = Project.new(name: "new", organisation: organisations(:one), owner: users(:one))
  end

  test "the validation" do
    assert @project.valid?
  end

  test "name validation" do
    @project.name = "a" * 51
    assert_not @project.valid?
  end

  test "organisation validation" do
    @project.organisation = nil
    assert_not @project.valid?
  end

  test "owner validation" do
    @project.owner = nil
    assert_not @project.valid?
  end
end
