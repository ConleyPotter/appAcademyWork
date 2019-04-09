Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :artworks, only: [:index, :show, :create, :update, :destroy]
  resource :artwork_shares, only: [:create]

  delete '/artwork_shares/:id', to: 'artwork_shares#destroy'
end
