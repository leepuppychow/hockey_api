Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/ping', to: "ping#index"
      resources :teams, only: [:index], param: :abbr do
        resources :players, only: [:index]
      end
    end
  end
end
