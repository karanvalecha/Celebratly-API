json.extract! status_upload, :id
json.image_url status_upload.image_upload.url
json.url occurrence_image_upload_url(@occurrence, status_upload, format: :json)
