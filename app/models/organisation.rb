# frozen_string_literal: true

class Organisation < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :organisation_memberships, dependent: :restrict_with_error
  has_many :projects, dependent: :restrict_with_error
  has_many :active_projects, -> { active }, class_name: "Project", inverse_of: "organisation"

  has_many :task_boards
  has_many :task_lists
  has_many :tasks
  
  has_one_attached :logo

  validates :name, presence: true, length: { maximum: 50 }
end
