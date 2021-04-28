class Occurrences::PublishController < ApplicationController
  before_action do
    @occurrence = Occurrence.find(params[:occurrence_id])
  end

  def create
    @occurrence.published_video.purge
    PublishVideoJob.perform_later(@occurrence)

    render json: {
      message: "Your video will be processed shortly at #{occurrence_url(@occurrence, format: :json)}",
      status: :ok
    }
  end
end
