json.extract! user, :id, :email, :full_name, :dob, :doj, :profile_url, :fcm_token
json.url user_url(user, format: :json)
