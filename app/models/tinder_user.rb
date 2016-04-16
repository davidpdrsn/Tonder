class TinderUser < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :matches

  def self.create_from_json(json, liker)
    user = TinderUser.create!(
      tinder_id: json.fetch("_id"),
      name: json.fetch("name"),
      bio: json.fetch("bio"),
      gender: json.fetch("gender"),
      birth_date: json.fetch("birth_date"),
    )
    json["photos"].each do |photo|
      user.images.create!(url: photo["url"])
    end
    user
  end

  def image_urls
    images.pluck(:url)
  end

  def broadcast_like
    html = ApplicationController.renderer.render(
      partial: "tinder_users/tinder_user",
      locals: { tinder_user: self },
    )
    ActionCable.server.broadcast "liked_users", tinder_user: html
  end
end
