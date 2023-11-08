Rails.application.routes.draw do
  devise_for :users
  root to: "user#index"

  resources :user, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [ :new, :create] 
      resources :likes, only: [:create]
    end
  end

end
