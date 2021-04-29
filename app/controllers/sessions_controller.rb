class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    unless request.headers['Android-Secret'].present? && request.headers['Android-Secret'] == ENV['ANDROID_SECRET']
      head :unauthorized and return
    end

    user = User.find_by_email(sign_in_params[:email])

    if user
      @new_user_session = true
      @current_user = user
    else
      render json: { errors: { 'email' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end
end