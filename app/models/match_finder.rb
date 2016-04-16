class MatchFinder < ApplicationRecord
  belongs_to :liker

  def start
    update!(running: true, error: nil, failed_at: nil)
    MatchFinderJob.perform_later(self)
  end

  def stop
    update!(running: false)
    broadcast
  end

  def failed(message:)
    update!(error: message, failed_at: Time.now)
    stop
  end

  private

  def broadcast
    html = ApplicationController.renderer.render(partial: "matches/actions",
                                                 locals: { match_finder: self })
    ActionCable.server.broadcast("match_finder_stopped", match_finder: html)
  end
end
