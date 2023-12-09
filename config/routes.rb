Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users',
    sessions: 'users/sessions',
    omniauth_callbacks: 'callbacks' 
  } 

  resources :users do
    resources :custom_fields
  end
  root "home#index" 
end
