# frozen_string_literal: true

class TaskBoard < ApplicationRecord
  belongs_to :organisation
  belongs_to :project
  belongs_to :owner, class_name: "User"

  after_update :morph

  has_many :task_lists, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 50 }
end
