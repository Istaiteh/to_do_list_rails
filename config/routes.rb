Rails.application.routes.draw do
  resources :todos
  resources :posts, only: [:index, :show] do 
    resources :comments, only: [:index, :show]
  
  end
  post "users/create", to: "users#create"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
