Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    mount Ckeditor::Engine => "/ckeditor"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :districts
    resources :blogs do
      resources :likes
      resources :comments
    end
    resources :bookmarks, only: %i(create destroy)
    resources :places do
      resources :comments
    end
  end
end
