Rails.application.routes.draw do
  root 'static_pages#index'
  resources :chat_rooms, only: [:create, :show, :index]
  match '/users', to:'static_pages#show', via: 'get'
  match '/chat_rooms/new/(:id)', to:'chat_rooms#new', via: 'get', as: 'new_chat_room'

  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations"}

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
