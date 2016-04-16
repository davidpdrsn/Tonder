Rails.application.routes.draw do
  resources :likers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post :start
      post :stop
    end
  end

  resources :tinder_users, only: [:show]

  root to: redirect("/likers/new")

  mount ActionCable.server => "/cable"
end
