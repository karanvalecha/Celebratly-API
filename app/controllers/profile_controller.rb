class ProfileController < ApplicationController
  def show
    render current_user
  end

  def update
    current_user.update(params.permit(:profile_url, :fcm_token))

    render current_user
  end
end
