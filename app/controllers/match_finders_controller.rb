class MatchFindersController < ApplicationController
  def start
    liker = Liker.find(params[:liker_id])
    liker.match_finder.start
    redirect_to liker
  end

  def stop
    liker = Liker.find(params[:liker_id])
    liker.match_finder.stop
    redirect_to liker
  end
end
