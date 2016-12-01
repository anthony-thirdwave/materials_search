Rails.application.routes.draw do
  root 'pages#index'
  resources :materials
  resources :companies
  get 'search', to: 'search#search'
end
