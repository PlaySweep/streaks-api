Rails.application.routes.draw do
  post 'authenticate', to: 'auth#authenticate'
  namespace :v1, defaults: { format: :json } do
    resources :users, only: [:show, :create, :update]
    resources :picks, only: [:show]
    resources :prizes, only: [:index, :show]
    resources :rounds, only: [:index, :show]
    resources :leaderboards, only: [:index]
    resources :users do
      scope module: :users do
        resources :cards, only: [:index, :create, :update]
        resources :picks, only: [:index, :create]
        resources :orders, only: [:create]
      end
    end
  end
end
