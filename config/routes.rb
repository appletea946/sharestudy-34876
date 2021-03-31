Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'search'
    end
    resources :like_users, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "articles#index"
  resources :articles, only: [:index, :new, :create, :show, :edit, :update] do
    resources :comments, only: [:create]
    collection do
      get 'search'
      get 'tag_search'
    end
    resources :like_articles, only: [:create, :destroy]
  end

  resources :groups, only: [:index, :new, :create, :show] do
    collection do
      get 'search'
      get 'sign_up'
      post 'sign_in'
    end
  end
end
