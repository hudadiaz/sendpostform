Rails.application.routes.draw do
  root 'demo#index'
  get 'mailboxes/current', to: 'mailboxes#show', as: :current_mailbox
  resources :mailboxes, only: [:new, :show, :create, :destroy] do
    resources :messages, only: [:index, :show, :destroy]
    resources :whitelists, only: [:index, :create, :destroy]
  end
  resources :messages, only: [:create]

  scope :confirmation, as: :confirmation do
    get '/', to: 'confirmation#index'
    post 'resend', to: 'confirmation#create'
  end

  scope :session, as: :session do
    get 'login', to: 'session#new'
    post '/', to: 'session#create'
    delete '/', to: 'session#destroy'
  end

  scope :reset, as: :reset do
    get '/', to: 'reset#index'
    post '/', to: 'reset#create'
    get 'apply', to: 'reset#apply'
    post 'api_key', to: 'reset#api_key'
    post 'access_token', to: 'reset#access_token'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
