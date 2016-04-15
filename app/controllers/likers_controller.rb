class LikersController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    if Liker.any?
      redirect_to Liker.first
    else
      @liker = Liker.new
    end
  end

  def show
    @liker = Liker.find(params[:id])
  end

  def create
    @liker = Liker.new(liker_params)

    if @liker.save
      redirect_to @liker
    else
      render :new
    end
  end

  def edit
    @liker = Liker.find(params[:id])
  end

  def update
    @liker = Liker.find(params[:id])

    if @liker.update(liker_params)
      redirect_to @liker
    else
      render :edit
    end
  end

  def destroy
    @liker = Liker.find(params[:id])
    @liker.stop
    @liker.destroy
    redirect_to root_path
  end

  def start
    @liker = Liker.find(params[:id])
    @liker.start
    flash.notice = "Liker started!"
    redirect_to @liker
  end

  def stop
    @liker = Liker.find(params[:id])
    @liker.stop
    flash.notice = "Liker stopped!"
    redirect_to @liker
  end

  private

  def liker_params
    params.require(:liker).permit(:facebook_id, :facebook_token)
  end
end
