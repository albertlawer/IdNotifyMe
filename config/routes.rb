Rails.application.routes.draw do
  resources :id_types, only: [:index, :show, :create, :update]
end
