class TaskBoardShowChannel < ApplicationCable::Channel
  def subscribed
    stream_or_reject_for TaskBoard.find(params[:id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
