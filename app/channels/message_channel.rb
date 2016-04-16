# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start_messaging(data)
    raise "Too many likers" if Liker.count > 1
    raise "No likers" if Liker.count.zero?

    MessageJob.perform_later(
      message: data["message"],
      match_tinder_ids: data["tinder_ids"],
    )
  end
end
