# frozen_string_literal: true

require "test_helper"

class OrganisationNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @organisation = Organisation.new(name: "New Organisation", domain: "hamnavoepartners.com")
  end

  test "should create new organisation with owner" do
    sign_in @bob
    assert_difference "Organisation.count", +1 do
      post_organisation
    end
    @saved_organisation = assigns(:organisation)
    assert_equal @bob.id, @saved_organisation.owner_id
    assert_save(@organisation, @saved_organisation, ["owner_id"])
    assert_redirected_to root_path
  end

  test "should not create new organisation" do
    sign_in @bob
    @organisation.name = "    "
    assert_no_difference "Organisation.count" do
      post_organisation
    end
    assert_template "new"
  end

  private

  def post_organisation
    post organisations_path(@organisation), params: parameters_from_instance(@organisation)
  end
end
