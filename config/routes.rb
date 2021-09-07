Rails.application.routes.draw do
  get 'searches/search'
  root "homes#top"
  get "home/about" => "homes#about"
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


  get '/search', to: 'searches#search'

  delete "users/:id", to: "users#destroy"

end