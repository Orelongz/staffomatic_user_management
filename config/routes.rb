Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index] do
    post :archive, on: :member
    post :unarchive, on: :member
  end
end
