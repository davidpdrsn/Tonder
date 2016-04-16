class MatchFinderJob < ApplicationJob
  queue_as :default

  def perform(liker)
    client = liker.client

    matches = client.fetch_updates(1.week.ago)["matches"]
    return if matches.nil?

    matches.each do |user|
      next unless user["person"].present?
      user = user["person"]

      tinder_user = TinderUser.find_by(tinder_id: user["_id"])
      if tinder_user.nil?
        tinder_user = TinderUser.create_from_json(user, liker)
      end

      liker.matches.find_or_create_by!(tinder_user: tinder_user)
    end
  end
end
