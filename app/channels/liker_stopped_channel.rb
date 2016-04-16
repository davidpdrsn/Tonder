# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class LikerStoppedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "liker_stopped"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
