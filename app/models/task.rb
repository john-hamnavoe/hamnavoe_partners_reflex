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
    cable_ready["morph"].morph(
      selector: dom_id(task_list.task_board) + "_show",
      html: render(partial: "task_boards/task_board_show", locals: { task_board: task_list.task_board, task_list: nil })
    )
    cable_ready.broadcast
  end
end
