class TinderUser < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :messages, dependent: :destroy

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

  def matched_by?(liker)
    matches.where(liker: liker).any?
  end

  def messaged_by?(liker)
    messages.where(liker: liker).any?
  end

  def image_urls
    images.pluck(:url)
  end
end
