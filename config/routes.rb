Rails.application.routes.draw do
  root 'pages#index'
  resources :materials
end
