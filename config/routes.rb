Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		resources :emails, only: [:create]
  	end
  end
end
