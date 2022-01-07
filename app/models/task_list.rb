# frozen_string_literal: true

class TaskList < ApplicationRecord
  belongs_to :task_board
  belongs_to :organisation
  belongs_to :project
  acts_as_list scope: :task_board

  after_commit :broadcast_board

  has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 50 }

  private

  def broadcast_board
    cable_ready["morph"].outer_html(
      selector: dom_id(task_board) + "_show",
      html: render(partial: "task_boards/task_board_show", locals: { task_board: task_board, task_list: nil })
    )
    cable_ready.broadcast
  end
end
