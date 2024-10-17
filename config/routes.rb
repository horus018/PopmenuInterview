Rails.application.routes.draw do
  resources :restaurants do
    resources :menus
  end

  resources :menus do
    resources :menu_items, only: [ :index, :create ] do
      delete "remove", action: :destroy_menu_item, on: :member
    end
  end

  resources :menu_items, only: [ :show, :update, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
