class WorkingProjectTasksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "WorkingProjectTasksChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
