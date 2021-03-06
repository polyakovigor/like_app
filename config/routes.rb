LikeApp::Application.routes.draw do
  root 'categories#index'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'registrations' }

  resources :categories do
    resources :images, only: %i[new create destroy]
  end

  resources :images, except: %i[new create destroy] do
    resource :likes, only: %i[create destroy]
  end

  resources :comments, only: :index

  resources :chat_rooms, only: %i[index show new create]

  resources :events, only: :index do
    collection do
      get :navigation
      get :user_sign_in
      get :user_sign_out
      get :user_likes
      get :user_comments
    end
  end

  mount ActionCable.server => '/cable'
end
