class PlansChannel < ApplicationCable::Channel
  def subscribed
    stream_from "plans_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
