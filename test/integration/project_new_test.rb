# frozen_string_literal: true

require "test_helper"

class ProjectNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @project = Project.new(name: "ProjectNewTest", start_date: Time.zone.today, end_date: Time.zone.today, is_active: true)
  end

  test "should create project within organisation" do
    sign_in @bob
    assert_difference "Project.count", + 1 do
      post_project
    end
    assert_redirected_to projects_path
    @saved_project = Project.find_by(name: "ProjectNewTest")
    assert_save @project, @saved_project, %w[owner_id organisation_id], "Expect to save and owner and organisation set based on user"
    assert_organisation(@saved_project, @bob.current_organisation)
  end

  test "should not create project within organisation" do
    sign_in @bob
    @project.name = "a" * 51
    assert_no_difference "Project.count" do
      post_project
    end
    assert_template "new"
    @saved_project = Project.find_by(name: "ProjectNewTest")
    assert_nil @saved_project
  end

  private

  def updated_fields
    %w[name start_date is_active end_date]
  end

  def post_project
    post projects_path, params: parameters_from_instance(@project)
  end
end
