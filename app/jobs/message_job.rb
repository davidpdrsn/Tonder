class MessageJob < ApplicationJob
  queue_as :default

  def perform(message:, match_tinder_ids:)
    matches = Match.where(tinder_id: match_tinder_ids)
    return unless matches.present?

    liker = matches.first.liker
    client = liker.client

    matches.each do |match|
      tinder_user = match.tinder_user

      return unless tinder_user.messages.where(liker: liker).empty?

      response = client.send_message(
        match.tinder_id,
        message,
      )
      ActionCable.server.broadcast(
        "message",
        type: "response",
        response: response,
      )
      return unless response["sent_date"].present?

      tinder_user.messages.create!(
        liker: liker,
        message: message,
        match: match,
      )
    end
  end
end
