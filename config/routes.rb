Rails.application.routes.draw do

  root 'index#index'

  resources :members, only: [:index, :new, :create, :show] do
    resources :search, only: [:index], controller: 'members/search'
    resources :friendships, only: [:create], controller: 'members/friendships'
  end


end
