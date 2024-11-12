Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/table/:tableN', to: 'dynamic#index'
  get '/procedure/:procedurename', to: 'dynamic_procedure#index'
  get '/procedure/:procedurename/:Valor', to: 'dynamic_procedureparam#index'
  get '/procedure/:proceduregeo', to: 'dynamic_proceduregeo#index'
  

  post 'login', to: 'authentication#login'
  
  # Defines the root path route ("/")
  # root "posts#index"
end
