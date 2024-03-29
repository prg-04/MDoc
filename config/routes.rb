Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # devise_for :patients
  resources :appointments
  resources :patients
  resources :doctors

  devise_for :patients, path: 'auth/', path_names: {
                                         sign_in: 'login',
                                         registration: 'signup'
                                       },
                        controllers: {
                          sessions: 'patients/sessions',
                          registrations: 'patients/registrations'
                        }

  post 'auth/logout', to: 'patients/sessions#destroy', as: :logout

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
