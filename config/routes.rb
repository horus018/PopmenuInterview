Rails.application.routes.draw do
  get "routes", to: "routes#index"

  resources :restaurants do
    resources :menus do
      resources :menu_items
    end
  end

  post "/import", to: "importations_v1#import"

  get "up" => "rails/health#show", as: :rails_health_check
end
