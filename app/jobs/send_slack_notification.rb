class SendSlackNotification < ActiveJob::Base
  include SuckerPunch::Job
  
  def perform
    slack_hook_url = ENV['SLACK_GENERAL_HOOK']
    return unless slack_hook_url.present?

    occs_due_today = [Occurrence.find(34)]
    # .where("DATE(start_at) = DATE(?)", Date.today).all
    occs_due_today.each do |occurrence|

      HTTParty.post(
        slack_hook_url,
        body: get_payload(occurrence),
      )
    end
  end  

  def get_payload occurrence
    return {
      blocks: [
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: get_message(occurrence)
          }
        },
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: get_sub_message(occurrence)
          }
        },
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: get_video_message(occurrence)
          }
        },
        {
          type: "image",
          image_url: get_thumbnil_url(occurrence),
          alt_text: "inspiration"
        }
      ]
    }.to_json
  end

  def get_message occurrence
    user = occurrence.event.reference

    if occurrence.event.event_type == 'birthday'
      message = "*Happy Birthday #{user.full_name}* :tada:"
    elsif occurrence.event.event_type == 'work_anniversary'
      message = "Happy Work anniversary *#{user.full_name}*."
    else
      message = occurrence.title
    end
  end

  def get_thumbnil_url occurrence
    "https://res.cloudinary.com/hbwugi9ry/video/upload/v1619422665/compiled_videos/3y2zobjer97wa4xe4xivfvv9k1s2.jpg"
  end

  def get_sub_message occurrence
    if occurrence.event.event_type == 'birthday'
      sub_message = "May you live longer"
    else
      sub_message = occurrence.title
    end
    return ">#{sub_message}"
  end

  def get_video_message occurrence
    "<https://res.cloudinary.com/hbwugi9ry/video/upload/v1619422665/compiled_videos/3y2zobjer97wa4xe4xivfvv9k1s2.mp4|Click here to play the video>"
  end
end
