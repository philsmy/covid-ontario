Rails.application.routes.draw do
  get 'ontario', to: 'ontario#index'
  get 'ontario/:district', to: 'ontario#district'
  get 'ontario_map_data', to: 'ontario#map_data'
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'ontario#index'
end
