PodClik::Application.routes.draw do
  resources :auth, only: [] do
    collection do
      post :signin
      post :signout
      post :phone
    end
  end

  resources :password_reset, only: [:create, :edit, :update]

  namespace :v1, format: :json do
    resources :schools, only: [:index]
    resources :sessions, only: [:create]

    resources :users, only: [:create, :show, :update], format: :json do
      collection do
        get :self, to: 'users#me'
      end
    end
  end
end
