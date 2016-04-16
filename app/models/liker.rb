class Liker < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :tinder_users, dependent: :destroy

  validates :facebook_id, :facebook_token, presence: true

  def start
    update!(running: true, error: nil, failed_at: nil)
    LikerJob.perform_later(self)
  end

  def stop
    update!(running: false)
    html = ApplicationController.renderer.render(partial: "likers/liker",
                                                 locals: { liker: self.reload })
    ActionCable.server.broadcast("liker_stopped", liker: html)
  end

  def failed(message:)
    update!(error: message, failed_at: Time.now)
    stop
  end

  def client
    client = TinderPyro::Client.new
    client.sign_in(facebook_id, facebook_token)
    client
  end
end
