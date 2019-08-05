Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    mount Ckeditor::Engine => "/ckeditor"

    resources :blogs
  end
end
