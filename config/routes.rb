Rails.application.routes.draw do
  get 'home/index'

  devise_for :guests
  
  resources :guests do
    resources :profiles
  end

  root 'home#index'

end
