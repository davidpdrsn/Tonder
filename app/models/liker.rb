class Liker < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tinder_users, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_one :match_finder, dependent: :destroy

  validates :facebook_id, :facebook_token, presence: true

  def start
    update!(running: true, error: nil, failed_at: nil)
    LikerJob.perform_later(self)
  end

  def stop
    update!(running: false)
    broadcast
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

  def match_finder
    finder = super

    if finder.nil?
      MatchFinder.create!(liker: self)
    else
      finder
    end
  end

  private

  def broadcast
    html = ApplicationController.renderer.render(partial: "likers/actions",
                                                 locals: { liker: self.reload })
    ActionCable.server.broadcast("liker_stopped", liker: html)
  end
end
