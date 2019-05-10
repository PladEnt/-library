Rails.application.routes.draw do
  resources :reviews
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :books, only: [:index, :show]
  end
  resources :books

end
