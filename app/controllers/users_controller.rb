class UsersController < ApplicationController
  def index
    render User.all
  end

  def show
    render User.find(params[:id])
  end
end
