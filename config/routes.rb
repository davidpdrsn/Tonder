Rails.application.routes.draw do
  resources :likers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post :start
      post :stop
    end
  end

  root to: redirect("/likers/new")
end