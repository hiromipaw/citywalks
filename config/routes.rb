Rails.application.routes.draw do
  # rooting
  root 'api/v1/walks#index'

  namespace :api do
    namespace :v1 do
      get '/walks', :to => 'walks#index'

    end
  end
end
