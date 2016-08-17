Rails.application.routes.draw do
  root 'static_pages#index'
  resources :chat_rooms, only: [:create, :show, :index]
  match '/users', to:'static_pages#show', via: 'get'
  match '/chat_rooms/new/(:id)', to:'chat_rooms#new', via: 'get', as: 'new_chat_room'
  match '/users/ban/(:id)', to:'static_pages#ban', via: 'post', as:'ban'
  match '/users/unban/(:id)', to:'static_pages#unban', via: 'post', as: 'unban'

  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations"}

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
