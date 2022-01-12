# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :task_list
  belongs_to :organisation
  belongs_to :project
  belongs_to :assigned_to, class_name: "User", optional: true
  acts_as_list scope: :task_list

  after_commit :broadcast_board

  validates :title, presence: true, length: { maximum: 100 }

  private

  def broadcast_board
    StreamTaskBoardJob.perform_now(task_list.task_board, self)
  end
end
