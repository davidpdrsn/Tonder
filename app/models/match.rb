class Match < ApplicationRecord
  belongs_to :liker
  belongs_to :tinder_user

  def broadcast_match
    html = ApplicationController.renderer.render(
      partial: "tinder_users/tinder_user",
      locals: { tinder_user: tinder_user },
    )
    ActionCable.server.broadcast "match_found", tinder_user: html
  end
end
