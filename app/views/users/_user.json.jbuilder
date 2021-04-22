json.(user, :id, :email, :full_name, :dob, :doj)
json.merge!({ token: user.generate_jwt }) if @new_user_session
