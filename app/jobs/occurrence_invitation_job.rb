class OccurrenceInvitationJob
  include SuckerPunch::Job
  
  def perform
    fcm = FCM.new(ENV['FIREBASE_SERVER_KEY'])
    occs_due = Occurrence.all.select {|o| StatusUploadPolicy.new(o).allow_upload? }

    occs_due.each do |occurrence|
      fcm_tokens = User.all_except(occurrence.event.reference).pluck(:fcm_token).compact
      options = { "notification": notification_payload(occurrence) }
      response = fcm.send(fcm_tokens, options)
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
      "Its #{occurrence.event.reference.short_name}'s Birthday Tomorrow"
    else
      "Its #{occurrence.event.reference.short_name}'s Workiversary Tomorrow"
    end
  end

  def get_thumbnil_url occurrence
    occurrence.reference.profile_url
  end
end