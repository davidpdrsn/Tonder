class MatchFinderJob < ApplicationJob
  queue_as :default

  def perform(match_finder)
    return unless match_finder.running

    liker = match_finder.liker
    client = liker.client

    response = client.fetch_updates(1.week.ago)
    matches = response["matches"]
    if matches.nil?
      match_finder.failed(message: "Invalid response #{response}")
      return
    end

    matches.each do |user|
      next unless user["person"].present?
      user = user["person"]

      tinder_user = TinderUser.find_by(tinder_id: user["_id"])
      if tinder_user.nil?
        tinder_user = TinderUser.create_from_json(user, liker)
      end

      liker.matches.find_or_create_by!(tinder_user: tinder_user)
    end

    self.class.set(wait: 10.minutes).perform_later(match_finder)
  rescue => error
    match_finder.failed(message: "#{error.message}\n#{error.backtrace.join("\n")}")
    raise error
  end
end
