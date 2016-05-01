class Like < ApplicationRecord
  belongs_to :liker
  belongs_to :tinder_user

  after_create_commit do
    html = ApplicationController.renderer.render(
      partial: "tinder_users/tinder_user",
      locals: {
        tinder_user: tinder_user,
        liker: liker,
        on_match_view: false,
      },
    )
    ActionCable.server.broadcast "liked_users", tinder_user: html
  end
end
