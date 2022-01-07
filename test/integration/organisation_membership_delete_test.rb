# frozen_string_literal: true

require "test_helper"

class OrganisationMembershipDeleteTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @organisation = organisations(:one)
    @bob = users(:one)
    @jessica = users(:three)
  end

  test "should create and delete new memberhip" do
    sign_in @bob
    assert_difference "OrganisationMembership.count", +1 do
      post organisation_memberships_path, params: { organisation_membership: { user_id: @jessica.id } }
    end
    organisation_membership = OrganisationMembership.find_by(user_id: @jessica.id, organisation_id: @organisation.id)

    assert_difference "OrganisationMembership.count", -1 do
      delete organisation_membership_path(organisation_membership)
    end
  end

  test "should not delete owner membership" do
    sign_in @bob
    organisation_membership = OrganisationMembership.find_by(user_id: @bob.id, organisation_id: @organisation.id)
    assert_not organisation_membership.nil?

    assert_no_difference "OrganisationMembership.count" do
      delete organisation_membership_path(organisation_membership)
    end
  end
end
