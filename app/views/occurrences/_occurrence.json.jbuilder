json.extract! occurrence, :id, :title, :event_id, :expires_at, :note, :start_at, :end_at, :caption
json.url occurrence_url(occurrence, format: :json)
json.event_type occurrence.event.event_type
json.color occurrence.event.color
json.final_video_url occurrence.published_video.url
json.allow_upload StatusUploadPolicy.new(occurrence).allow_upload?
json.status_uploads do
  json.array! occurrence.status_uploads, partial: "status_uploads/status_upload", as: :status_upload
end