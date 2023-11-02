Rails.application.routes.draw do
  root to: "user#index"

  resources :user, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [ :new, :create] 
      resources :like, only: [:create], as: :likes
    end
  end

end
