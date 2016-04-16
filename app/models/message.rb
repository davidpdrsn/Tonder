class Message < ApplicationRecord
  belongs_to :tinder_user
  belongs_to :liker
  belongs_to :match

  after_create_commit do
    html = ApplicationController.renderer.render(
      partial: "tinder_users/tinder_user",
      locals: {
        tinder_user: tinder_user,
        liker: liker,
      },
    )
    ActionCable.server.broadcast(
      "message",
      type: "sent_message",
      tinder_user_html: html,
      tinder_match_id: match.id,
    )
  end
end
