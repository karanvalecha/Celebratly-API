json.extract! user, :id, :email, :full_name, :dob, :doj, :profile_url
json.url user_url(user, format: :json)
