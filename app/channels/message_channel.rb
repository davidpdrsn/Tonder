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

  def pretend_message(data)
    MessageJob.perform_now(
      message: "__pretend_message__",
      match_ids: [data["match_id"]],
    )
  end
end
