class MatchFinder < ApplicationRecord
  belongs_to :liker

  def start
    update!(running: true, error: nil, failed_at: nil)
    MatchFinderJob.perform_later(self)
  end

  def stop
    update!(running: false)
    # html = ApplicationController.renderer.render(partial: "likers/actions",
    #                                              locals: { liker: self.reload })
    # ActionCable.server.broadcast("liker_stopped", liker: html)
  end

  def failed(message:)
    update!(error: message, failed_at: Time.now)
    stop
  end
end
