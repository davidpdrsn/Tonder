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
  end

  def failed(message:)
    stop
    update!(error: message, failed_at: Time.now)
  end

  def client
    client = TinderPyro::Client.new
    client.sign_in(facebook_id, facebook_token)
    client
  end
end
