Rails.application.routes.draw do
  root "aquariums#index"

  resources :aquariums do
    get :chart_data, on: :member
    resources :measurements, except: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
