class LikerJob < ApplicationJob
  queue_as :default

  def perform(liker)
    @liker = liker
    return unless liker.running

    like_nearby_users

    liker.stop if liker.running

    # self.class.perform_later(liker) if liker.running
  rescue => error
    liker.failed(message: "#{error.message}\n#{error.backtrace.join("\n")}")
    raise error
  end

  private

  attr_reader :liker

  def like_nearby_users
    response = client.get_nearby_users
    results = response["results"]

    if results.blank?
      liker.failed(message: "Invalid response: #{response}")
      return
    end

    results.each do |user|
      return unless liker.running
      if user["name"] == "Tinder Team"
        liker.failed(message: user["bio"])
        return
      end

      tinder_user = TinderUser.find_by(tinder_id: user["_id"])

      if tinder_user.nil?
        tinder_user = TinderUser.create_from_json(user, liker)
      end

      like_user(tinder_user)
    end
  end

  def like_user(tinder_user)
    response = client.like(tinder_user.tinder_id)

    if response.key?("match")
      liker.likes.create!(tinder_user: tinder_user)
    else
      liker.failed(message: "Failed liking: #{response}")
    end
  end

  def stop_with_message(message)
    liker.failed(message: message)
  end

  def client
    @client ||= liker.client
  end
end
