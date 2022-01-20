class IssueCommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for Issue.find(params[:id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
