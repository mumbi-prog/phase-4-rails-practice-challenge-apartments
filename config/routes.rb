Rails.application.routes.draw do
 
  resources :leases, only: [:index, :create, :destroy]
  resources :tenants, only: [:index, :show, :create, :update, :destroy]
  resources :apartments, only: [:index, :show, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
