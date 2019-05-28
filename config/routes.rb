Rails.application.routes.draw do
  resources :reviews
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'
  resources :users do
    resources :books
  end
  resources :books do
    resources :reviews
  end
  get '/good_books', to: 'books#good_books'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  delete '/logout', to: 'users#logout'
  get '/auth/facebook/callback' => 'sessions#create'
end
