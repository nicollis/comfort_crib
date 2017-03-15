Rails.application.routes.draw do
  get 'home/index'

  devise_for :guests
  
  resources :guests, only: :none do
    resource :profile
  end

  root 'home#index'

end
