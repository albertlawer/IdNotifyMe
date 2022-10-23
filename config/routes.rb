Rails.application.routes.draw do
  post '/login' => 'sessions#login', as: :login
  post '/signup' => 'sessions#signup', as: :signup
  resources :id_types, only: [:index, :show, :create, :update]
end
