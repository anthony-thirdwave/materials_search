Rails.application.routes.draw do
  root 'pages#index'
  resources :materials do
    collection do
      get :autocomplete
    end
  end
  resources :companies
  get 'search', to: 'search#search'
end
