Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :artworks, only: [:show, :create, :update, :destroy]
  resources :artwork_shares, only: [:create, :destroy]

  resources :users do
    resources :artworks, only: :index
  end

  resources :comments, only: [:create, :destroy, :index]

  resources :likes, only: [:create, :destroy, :index]
  
  resources :favorites, only: [:create, :destroy]
  resources :favorites do
    member do
      get 'users_favorites'
      get 'artworks_favoriters'
    end
  end

  resources :collections_of_artworks, only: [:create, :destroy]
  resources :collections_of_artworks do
    member do
      get 'users_collections'
    end
  end
end
