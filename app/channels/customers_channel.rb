class CustomersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "customers_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
