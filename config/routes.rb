Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users',
    sessions: 'users/sessions',
    omniauth_callbacks: 'callbacks' 
  } 

  resources :users, only: [:index, :show, :new, :edit, :create] do
    member do
      delete 'destroy_user', to: 'users#destroy_user'
    end

    resources :custom_fields
  end
  root "home#index" 
end
