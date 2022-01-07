class MorphChannel < ApplicationCable::Channel
  def subscribed
    stream_from "morph"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
