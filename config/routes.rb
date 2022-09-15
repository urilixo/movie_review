Rails.application.routes.draw do
  resources :genres
  root 'movies#index'

  get 'movies/filter/:filter' => 'movies#index', as: :filtered_movies
  resources 'movies' do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  resource 'session', only: %i[new create destroy]

  resources :users
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
end
