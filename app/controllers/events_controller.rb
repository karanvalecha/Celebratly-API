class EventsController < ApplicationController
  def index
    render Event.all
  end
end
