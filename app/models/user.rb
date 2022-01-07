# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :current_organisation, class_name: "Organisation", optional: true
  belongs_to :current_project, class_name: "Project", optional: true

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :organisation_memberships, dependent: :restrict_with_error

  has_person_name

  # Include default devise :invitable, modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
