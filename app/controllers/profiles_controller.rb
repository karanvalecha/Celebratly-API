class ProfilesController < ApplicationController
  def index
    render json: KiprosherProfile.all.map { |k| KiprosherProfileSerializer.new(k) }.as_json
  end
end
