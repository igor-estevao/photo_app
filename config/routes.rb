Rails.application.routes.draw do
  resources :images
  devise_for :users
  resources :charges
  
  resources :customers do
    get "cards", to: "customers#cards", as: "cards"
    # post "cards", to: "customers#cards", as: "cards"
    post "create_card", to: "customers#create_card", as: "create_card"
    post "set_default_card/:card_id", to: "customers#set_default_card", as: "set_default_card"
    delete "delete_card/:card_id", to: "customers#delete_card", as: "delete_card"
  end

  resources :plans do
    post "sign", to: "plans#sign", as: "sign"
    post "cancel", to: "plans#cancel", as: "cancel"
  end

  get "my_page", to: "welcome#my_page", as: "my_page"

  root "welcome#index"
end
