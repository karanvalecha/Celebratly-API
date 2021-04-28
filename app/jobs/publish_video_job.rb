class PublishVideoJob < ApplicationJob
  def perform(occurrence)
    video_path = OccurrenceVideoCreator.new(occurrence).make_video
    # send notification if any
  end
end