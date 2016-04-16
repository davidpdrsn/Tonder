# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start_messaging(data)
    MessageJob.perform_later(
      message: data["message"],
      match_ids: data["match_ids"],
    )
  end
end
