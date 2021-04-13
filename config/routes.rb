Rails.application.routes.draw do
  get 'text_status/show'
  resources :users
  resources :events do
    resources :occurrences, shallow: true
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
