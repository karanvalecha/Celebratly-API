class UsersController < ApplicationController
  before_action { params[:format] = :json }
  respond_to :json

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
