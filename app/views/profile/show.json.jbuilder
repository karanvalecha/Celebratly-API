json.partial! "users/user", user: current_user

json.occurrences do
  json.array!(
    current_user.occurrences.joins(:published_video_attachment),
    partial: 'occurrences/occurrence', as: :occurrence
  )
end
