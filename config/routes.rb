Rails.application.routes.draw do
  resource :profile, only: [:show, :update], controller: 'profile'
  get 'text_status/show'
  get 'sample', to: 'sample#show'
  resources :occurrences
  resources :users
  resources :events do
    resources :occurrences, shallow: true
  end

  resources :occurrences do
    resources :image_upload, module: 'occurrences'
    resource :publish, only: [:create], module: 'occurrences', controller: 'publish'
  end

  devise_for :users,
              path: '',
              path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
              },
              controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
              }, defaults: { format: :json }
end
