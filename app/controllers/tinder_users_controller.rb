class TinderUsersController < ApplicationController
  def show
    @tinder_user = TinderUser.find(params[:id])
  end
end
