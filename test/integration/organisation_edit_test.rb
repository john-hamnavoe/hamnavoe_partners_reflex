# frozen_string_literal: true

require "test_helper"

class OrganisationEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @archer = users(:four)
    @organisation = organisations(:one)
    update_organisation
  end

  test "should update organisation within organisation" do
    sign_in @bob
    assert_no_difference "Organisation.count" do
      put_organisation
    end
    assert_redirected_to root_path
    @saved_organisation = Organisation.find_by(id: @organisation.id)
    assert_save @organisation, @saved_organisation
  end

  test "should not update organisation within organisation" do
    sign_in @bob
    @organisation.name = "      "
    assert_no_difference "Organisation.count" do
      put_organisation
    end
    assert_template "edit"
    @saved_organisation = Organisation.find_by(id: @organisation.id)
    assert_no_save @organisation, @saved_organisation, updated_fields
  end

  test "should not update organisation within organisation when not logged in" do
    assert_no_difference "Organisation.count" do
      put_organisation
    end
    assert_redirected_to new_user_session_path
    @saved_organisation = Organisation.find_by(id: @organisation.id)
    assert_no_save @organisation, @saved_organisation, updated_fields
  end

  test "should not update organisation if not owner" do
    sign_in @archer
    assert_no_difference "Organisation.count" do
      put_organisation
    end
    assert_redirected_to root_path
  end

  private

  def updated_fields
    %w[name restrict_to_domain active]
  end

  def update_organisation
    @organisation.name = "new name"
    @organisation.active = !@organisation.active
    @organisation.restrict_to_domain = !@organisation.restrict_to_domain
  end

  def put_organisation
    put organisation_path(@organisation), params: parameters_from_instance(@organisation)
  end
end
