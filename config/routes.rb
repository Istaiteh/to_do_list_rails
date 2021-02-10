Rails.application.routes.draw do
  resources :todos
  post "users/create", to: "users#create"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
