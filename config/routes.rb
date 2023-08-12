Rails.application.routes.draw do
  devise_for :users
  root 'movies#latest'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :movies, only: [:show] do
    collection do
      get :latest
      get :favourites
      get :search_movie
    end
    post :add_to_favourite_list
  end
  
  get :callback, to: 'tmdb_auth#callback'



  # Defines the root path route ("/")
  # root "articles#index"
end
