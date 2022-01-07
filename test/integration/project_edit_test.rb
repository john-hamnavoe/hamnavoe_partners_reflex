# frozen_string_literal: true

require "test_helper"

class ProjectEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @project = projects(:one)
    update_project
    @organisation = organisations(:one)
  end

  test "should update project within organisation" do
    sign_in @bob
    assert_no_difference "Project.count" do
      put_project
    end
    assert_redirected_to projects_path
    @saved_project = Project.find_by(id: @project.id)
    assert_save @project, @saved_project
  end

  test "should not update project within organisation" do
    sign_in @bob
    @project.name = "a" * 51
    assert_no_difference "Project.count" do
      put_project
    end
    assert_template "edit"
    @saved_project = Project.find_by(id: @project.id)
    assert_no_save @project, @saved_project, updated_fields
  end

  test "should not update project in other organisation" do
    @project = projects(:two)
    update_project
    sign_in @bob
    assert_no_difference "Project.count" do
      put_project
    end
    assert_response :unprocessable_entity
    @saved_project = Project.find_by(id: @project.id)
    assert_no_save @project, @saved_project, updated_fields
  end

  private

  def updated_fields
    %w[name start_date is_active end_date]
  end

  def update_project
    @project.name = "new name"
    @project.start_date = Time.zone.today
    @project.end_date = Time.zone.today
    @project.is_active = !@project.is_active
  end

  def put_project
    put project_path(@project), params: parameters_from_instance(@project)
  end
end
