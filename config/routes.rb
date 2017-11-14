Rails.application.routes.draw do
  root 'demo#index'
  get 'mailboxes/current', to: 'mailboxes#show', as: :current_mailbox
  resources :mailboxes, only: [:new, :show, :create, :destroy] do
    resources :messages, only: [:index, :show, :destroy] do
      collection do
        delete :delete_all, to: 'messages#delete_all'
      end
    end
    resources :whitelists, only: [:index, :create, :destroy]
  end
  resources :messages, only: [:create]

  scope :confirmation, as: :confirmation do
    get '/', to: 'confirmation#index'
    post 'resend', to: 'confirmation#create'
  end

  scope :session, as: :session do
    delete '/', to: 'session#destroy'
  end

  scope :magic, as: :magic do
    get '/', to: 'magic#index'
    post '/', to: 'magic#create'
    get 'login', to: 'magic#login'
  end

  scope :reset, as: :reset do
    post 'api_key', to: 'reset#api_key'
    post 'access_token', to: 'reset#access_token'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
