json.events do |json|
  json.array! @events, partial: 'events/event', as: :event
end
