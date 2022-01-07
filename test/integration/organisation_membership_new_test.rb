# frozen_string_literal: true

require "test_helper"

class OrganisationMembershipNewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:one)
    @jessica = users(:three)
  end

  test "should create new memberhip" do
    sign_in @bob
    assert_difference "OrganisationMembership.count", +1 do
      post organisation_memberships_path, params: { organisation_membership: { user_id: @jessica.id } }
    end
  end

  test "should not create duplicate new memberhip" do
    sign_in @bob
    assert_no_difference "OrganisationMembership.count" do
      post organisation_memberships_path, params: { organisation_membership: { user_id: @bob.id } }
    end
  end

  test "should not create new memberhip when not signed in" do
    assert_no_difference "OrganisationMembership.count" do
      post organisation_memberships_path, params: { organisation_membership: { user_id: @jessica.id } }
    end
  end
end
