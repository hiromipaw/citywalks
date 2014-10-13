Rails.application.routes.draw do
  # rooting
  root 'api/v1/walks#index'

  namespace :api do
    namespace :v1 do
      resources :walks
    end
  end
end
