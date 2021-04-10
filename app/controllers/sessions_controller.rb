class SessionsController < Devise::SessionsController
  respond_to :json
  # skip_before_action :authenticate_user

  def create
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