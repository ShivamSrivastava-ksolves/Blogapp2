Rails.application.routes.draw do

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


devise_for :users, controllers: {
  registrations: 'users/registrations'
}

resources :users, only: [:show]




  get 'home/about'
  get 'home/upgrade'
  get 'posts/myposts'
  post 'like', to: 'posts#like'



  resources :posts do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
