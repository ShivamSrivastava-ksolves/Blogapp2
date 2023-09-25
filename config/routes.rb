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
  post 'stripe/webhooks', to: 'stripe/webhooks#create'
  get 'pricing', to: 'stripe/checkout#pricing'
  post 'stripe/checkout', to: 'stripe/checkout#checkout'
  get 'stripe/checkout/success', to: 'stripe/checkout#success'
  get 'stripe/checkout/cancel', to: 'stripe/checkout#cancel'
  post 'stripe/billing_portal', to: 'stripe/billing_portal#create'

  # stripe listen --forward-to localhost:4242/stripe/webhooks


  resources :posts do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
