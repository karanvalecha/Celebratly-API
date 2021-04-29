upload_policy = StatusUploadPolicy.new(occurrence)

json.extract! occurrence, :id, :title, :event_id, :start_at, :end_at, :caption
json.url occurrence_url(occurrence, format: :json)
json.event_type occurrence.event.event_type
json.color occurrence.event.color
json.final_video_url occurrence.published_video.url

json.allow_upload upload_policy.allow_upload?
json.upload_time_distance_in_words upload_policy.upload_time_distance_in_words

json.status_uploads do
  json.array! occurrence.status_uploads, partial: "status_uploads/status_upload", as: :status_upload
end

if occurrence.reference
  if profile_url = occurrence.reference.profile_url
    json.photo_url profile_url
  end
end

json.action_text "Your message for #{occurrence.title}"