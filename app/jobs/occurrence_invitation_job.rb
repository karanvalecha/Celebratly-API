class OccurrenceInvitationJob
  include SuckerPunch::Job
  
  def perform
    fcm = FCM.new(ENV['FIREBASE_SERVER_KEY'])
    occs_due_tomorrow = Occurrence.all.select {|o| StatusUploadPolicy.new(o).notifiable? }

    occs_due_tomorrow.each do |occurrence|
      fcm_tokens = User.all_except(occurrence.event.reference).pluck(:fcm_token).compact
      options = { "notification": notification_payload(occurrence) }
      response = fcm.send(fcm_tokens, options)
    end
  end

  def notification_payload occurrence
    return {
      title: get_occurence_title(occurrence),
      body: occurrence.caption,
      image: "https://res.cloudinary.com/hbwugi9ry/video/upload/v1619422665/compiled_videos/3y2zobjer97wa4xe4xivfvv9k1s2.jpg"
    }
  end

  def get_occurence_title occurrence
    if occurrence.event.event_type == 'birthday'
      title = "Its #{occurrence.event.reference.short_name}'s Birthday"
    else
      title = "Its #{occurrence.event.reference.short_name}'s Workiversary"
    end
  end
end