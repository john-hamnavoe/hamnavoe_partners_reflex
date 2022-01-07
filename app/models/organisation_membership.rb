# frozen_string_literal: true

class OrganisationMembership < ApplicationRecord
  belongs_to :organisation
  belongs_to :user

  validates :organisation, uniqueness: { scope: :user }
end
