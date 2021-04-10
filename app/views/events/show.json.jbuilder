json.event do |json|
  json.partial! 'events/event', event: @event
end
