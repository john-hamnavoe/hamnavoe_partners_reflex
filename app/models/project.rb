# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :organisation

  has_many :task_boards
  has_many :task_lists
  has_many :tasks  

  validates :name, presence: true, length: { maximum: 50 }
  scope :active, -> { where(is_active: true).order(:name) }
end
