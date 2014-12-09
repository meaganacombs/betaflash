Rails.application.routes.draw do
 
  put 'users/:id/updatePinsVisited/:pinId' => 'users#updatePinsVisited' 
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :pins
  resources :comments

  root 'sessions#new'
  match '/users', to: 'users#show', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin',to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/pin/index', to: 'pin#index', via: 'get'
  match '/pin/create', to: 'pin#create', via: 'post'
  match '/pins/show', to: 'pins#show', via: 'get'
  match '/comments/:id', to: 'comments#delete_image', via: 'post'
  get 'comment/:id/remove_photo', to: 'comments#remove_photo', as: 'remove_comment_photo'
  

end
