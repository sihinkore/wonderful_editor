Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :articles do
        # get 'drafts/index'
        # get 'drafts/show'
        resources :drafts,except:[:new,:create,:update,:destroy]
      end
    end
  end
  root to: "home#index"

  # reload 対策
  get "sign_up", to: "home#index"
  get "sign_in", to: "home#index"
  get "articles/new", to: "home#index"
  get "articles/:id", to: "home#index"

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
      }
      resources :articles
    end
  end
end
