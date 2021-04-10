json.(user, :id, :email, :full_name, :dob, :doj)
json.token user.generate_jwt if @new_user_session
