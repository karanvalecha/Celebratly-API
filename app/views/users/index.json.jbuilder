json.users do |json|
  json.array! @users, partial: 'users/user', as: :user
end
