Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      post 'like', to: 'likes#create'
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  namespace :api do
    resources :users, only: [] do
      member do
        get :posts
      end
    end

    resources :posts, only: [] do
      member do
        get :comments
        post :add_comment
      end
    end
  end
end
