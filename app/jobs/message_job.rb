class MessageJob < ApplicationJob
  queue_as :default

  def perform(message:, match_ids:)
    matches = Match.where(id: match_ids)
    unless matches.present?
      Rails.logger.debug "No matches found"
      return
    end

    liker = matches.first.liker
    client = liker.client

    matches.each do |match|
      tinder_user = match.tinder_user

      unless tinder_user.messages.where(liker: liker).empty?
        Rails.logger.debug "No messages found"
        return
      end

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
