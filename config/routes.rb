Odot::Application.routes.draw do
  namespace :api do
    resources :todo_lists
  end

  get 'pages/home'

  get "/login" => "user_sessions#new", as: :login
  delete "/logout" => "user_sessions#destroy", as: :logout

  resources :users, except: [:show]
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :todo_lists do
    put :email, on: :member
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end
  root 'pages#home'
end
