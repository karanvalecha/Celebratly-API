class SystemWisherJob
  include SuckerPunch::Job
  
  def perform
    fcm = FCM.new(ENV['FIREBASE_SERVER_KEY'])
    occs_due_today = Occurrence.where("DATE(start_at) = DATE(?)", Date.today).all

    occs_due_today.each do |occurrence|
      user_fcm_token = occurrence.event.reference.fcm_token
      options = { "notification": notification_payload(occurrence) }
      response = fcm.send(user_fcm_token, options)
    end
  end

  def notification_payload occurrence
    return {
      title: get_occurence_title(occurrence),
      body: occurrence.caption,
      image: get_thumbnil_url(occurrence)
    }
  end

  def get_occurence_title occurrence
    if occurrence.event.event_type == 'birthday'
      title = "Happy Birthday #{occurrence.event.reference.full_name}"
    elsif occurrence.event.event_type == 'work_anniversary'
      title = "Happy Workiversary #{occurrence.event.reference.full_name}"
    else
      title = occurrence.title
    end
  end

  def get_thumbnil_url occurrence
    published_video_url = occurrence.published_video.url
    return published_video_url.sub /\.[^\.]+$/, '.jpg'
  end
end
