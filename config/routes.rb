Rails.application.routes.draw do
  resources :likers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post :start
      post :stop
    end

    resource :match_finder, only: [] do
      collection do
        post :start
        post :stop
      end
    end
  end

  resources :tinder_users, only: [:show]

  root to: redirect("/likers/new")

  mount ActionCable.server => "/cable"
end
