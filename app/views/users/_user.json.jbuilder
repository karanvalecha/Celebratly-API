json.(user, :id, :email, :full_name, :dob, :doj, :profile_url)
json.merge!({ token: user.generate_jwt }) if @new_user_session
