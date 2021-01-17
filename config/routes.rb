Rails.application.routes.draw do
  root to: 'activities#index'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  devise_scope :user do
    post 'set_email', to: 'oauth_callbacks#set_email'
  end
  resources :users, only: :show do
    resources :demotracks, only: %i[create destroy], shallow: true
    resources :posts, only: %i[create destroy], shallow: true
  end

  resources :activities, only: :index

  resources :conversations, only: :index
  resources :messages, only: %i[index create]
  resources :communities do
    resources :posts, only: %i[create destroy], shallow: true
  end

  resources :spotify_tracks, only: %i[create destroy]

  get 'search_tracks', to: 'spotify_tracks#search_tracks'
  get 'search', to: 'search#search'

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post

  mount ActionCable.server => '/cable'
end
