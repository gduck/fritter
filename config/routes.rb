Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  # resources :categories
  get 'categories' => 'categories#index'
  get 'categories/:name' => 'categories#show'

  get 'pins' => 'pins#index'
  get 'pins/:id' => 'pins#show'
  get 'likes' => 'likes#index'

  get '/user/get' => 'users#get'

  
end
