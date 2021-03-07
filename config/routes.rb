Rails.application.routes.draw do
  post 'authenticate', to: 'auth#authenticate'
  namespace :v1, defaults: { format: :json } do
    resources :users, only: [:show, :create, :update]
    resources :picks, only: [:show]
    resources :rounds, only: [:index, :show]
  end
end
