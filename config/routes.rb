Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"
  get 'searches/search'
  get '/search', to: 'searches#search'
  
  devise_for :users


  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end

  delete "users/:id", to: "users#destroy"

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]


end