Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    mount Ckeditor::Engine => "/ckeditor"
    resources :blogs
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
  end  
end
