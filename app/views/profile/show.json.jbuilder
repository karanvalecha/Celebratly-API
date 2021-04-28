json.partial! "users/user", user: current_user

json.occurrences do
  json.array! current_user.occurrences, partial: 'occurrences/occurrence', as: :occurrence
end
