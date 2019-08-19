Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    mount Ckeditor::Engine => "/ckeditor"

    resources :blogs do
      resources :comments
    end

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/auth/:provider/callback", to: "sessions#create"
    get "/auth/failure", to: "sessions#failure"

    resources :blogs do
      resources :likes
      resources :comments
    end

    resources :users do
      member do
        resources :followers
        resources :following
      end
    end

    resources :places do
      resources :comments
    end

    resources :users
    resources :districts
    resources :places
    resources :blogs
    resources :bookmarks, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
