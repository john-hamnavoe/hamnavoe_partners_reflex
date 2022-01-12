class StreamTaskBoardJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(task_board, task = nil)
    broadcast_board(task_board)
    broadcast_row(task) if task
  end

  private

  def broadcast_board(task_board)
    cable_ready[TaskBoardShowChannel].outer_html(
      selector: dom_id(task_board) + "_show",
      html: ApplicationController.render(partial: "task_boards/task_board_show", locals: { task_board: task_board, task_list: nil, task: nil })
    ).broadcast_to(task_board)
  end

  def broadcast_row(task)
    cable_ready[WorkingProjectTasksChannel].morph(
      selector: dom_id(task) + "_row",
      html: ApplicationController.render(partial: "working_project/tasks/task", locals: { task: task })
    ).broadcast
  end
end
