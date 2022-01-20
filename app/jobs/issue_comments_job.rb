class IssueCommentsJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform(issue)
    broadcast_comments(issue)
  end

  private

  def broadcast_comments(issue)
    cable_ready[IssueCommentsChannel].inner_html(
      selector: dom_id(issue) + "_comments",
      html: ApplicationController.render(partial: "comments/comment_control", locals: { commentable: issue })
    ).broadcast_to(issue)
  end
end
