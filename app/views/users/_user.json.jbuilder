json.extract! user, :id, :email, :full_name, :dob, :doj, :profile_url, :fcm_token
json.token user.generate_jwt if @new_user_session
