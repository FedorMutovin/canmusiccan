Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  devise_scope :user do
    post 'set_email', to: 'oauth_callbacks#set_email'
  end
  resources :users, only: :show do
    resources :demotracks, only: %i[create destroy], shallow: true
    resources :spotify_tracks, only: %i[create destroy], shallow: true
  end

  get 'search_tracks', to: 'spotify_tracks#search_tracks'
end
