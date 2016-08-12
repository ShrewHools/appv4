Rails.application.routes.draw do
  root 'static_pages#index'
  resources :chat_rooms, only: [:new, :create, :show, :index]
  match '/users', to:'static_pages#show', via: 'get'

  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
