Rails.application.routes.draw do
  resource :profile, only: [:show, :update], controller: 'profile'
  get 'text_status/show'
  get 'sample', to: 'sample#show'
  scope defaults: { format: :json } do
    resources :occurrences
    resources :users
    resources :events do
      resources :occurrences, shallow: true
    end
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
              }
end
