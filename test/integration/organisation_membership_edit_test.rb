# frozen_string_literal: true

require "test_helper"

class OrganisationMembershipEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @organisation = organisations(:one)
    @bob = users(:one)
    @jessica = users(:three)
  end

  test "should update membership admin status" do
    sign_in @bob
    post organisation_memberships_path, params: { organisation_membership: { user_id: @jessica.id } }
    organisation_membership = OrganisationMembership.find_by(user_id: @jessica.id, organisation_id: @organisation.id)
    assert_not organisation_membership.is_admin
    patch organisation_membership_path(organisation_membership), params: { organisation_membership: { is_admin: true } }
    organisation_membership.reload
    assert organisation_membership.is_admin
    patch organisation_membership_path(organisation_membership), params: { organisation_membership: { is_admin: false } }
    organisation_membership.reload
    assert_not organisation_membership.is_admin
  end

  test "should not update membership to admin when not signed in" do
    sign_in @bob
    post organisation_memberships_path, params: { organisation_membership: { user_id: @jessica.id } }
    organisation_membership = OrganisationMembership.find_by(user_id: @jessica.id, organisation_id: @organisation.id)
    assert_not organisation_membership.is_admin
    sign_out @bob
    patch organisation_membership_path(organisation_membership), params: { organisation_membership: { is_admin: true } }
    organisation_membership.reload
    assert_not organisation_membership.is_admin
  end
end
