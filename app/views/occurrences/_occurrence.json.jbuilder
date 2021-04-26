json.extract! occurrence, :id, :title, :event_id, :expires_at, :note, :start_at, :end_at, :caption
json.url occurrence_url(occurrence, format: :json)
json.event_type occurrence.event.event_type
json.color occurrence.event.color
json.final_video_url occurrence.published_video.url
