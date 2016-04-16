class LikersController < ApplicationController
  before_action :require_login, only: [:show,
                                       :create,
                                       :edit,
                                       :destroy,
                                       :start,
                                       :stop]
  before_action :ensure_user_owns_liker, only: [:show,
                                                :edit,
                                                :update,
                                                :destroy,
                                                :start,
                                                :stop]

  def index
    redirect_to root_path
  end

  def show
    @liker = current_user.liker
  end

  def new
    if signed_in?
      if current_user.liker.present?
        redirect_to current_user.liker
      else
        @liker = Liker.new
      end
    else
      redirect_to sign_in_path
    end
  end

  def create
    @liker = Liker.new(liker_params)
    @liker.user = current_user

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
    redirect_to @liker
  end

  def stop
    @liker = Liker.find(params[:id])
    @liker.stop
    redirect_to @liker
  end

  private

  def liker_params
    params.require(:liker).permit(:facebook_id, :facebook_token)
  end

  def ensure_user_owns_liker
    liker = Liker.find(params[:id])

    if current_user.liker.nil?
      flash.alert = "Create liker first"
      redirect_to root_path
    else
      unless current_user.liker.id == params[:id].to_i
        flash.alert = "Liker not found"
        redirect_to root_path
      end
    end
  end
end
