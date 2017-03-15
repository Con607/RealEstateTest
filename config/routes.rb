Rails.application.routes.draw do
  get 'pages/home'

  resources :pictures
  resources :estates
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "pages#home"
end
