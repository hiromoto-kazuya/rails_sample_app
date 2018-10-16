Rails.application.routes.draw do

  resources :blogs do
    collection do
      post :confirm
    end
    member do
      patch :edit_confirm
    end
  end

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :contacts


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
