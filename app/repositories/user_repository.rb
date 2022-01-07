# frozen_string_literal: true

class UserRepository < ApplicationRepository
  def all(args = {}, _params = nil)
    User.where(args).where(invitation_token: nil).where(id: OrganisationMembership.where(organisation: organisation).pluck(:user_id)).order(:last_name)
  end
end
