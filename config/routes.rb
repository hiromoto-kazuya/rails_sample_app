Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root "blogs#index"
  resources :blogs do
    collection do
      post :confirm
    end
    member do
      patch :edit_confirm
    end
    resources :comments
  end

  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :contacts
  resources :relationships, only: [:create, :destroy]


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
