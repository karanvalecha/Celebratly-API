class EventsController < ActionController::Base
  layout 'application'
  before_action -> { @event = event_class.find(params[:id]) }, except: [:new, :index, :create]

  def create
    @event = event_class.create!(params.require(:event).permit!)
    redirect_to events_path
  end

  def new
    @event = event_class.new
  end

  def index
    @events = event_class.all
  end

  def update
    @event.update(params.require(:event).permit!)
    redirect_to events_path
  end

  def destroy
    @event.destroy
    redirect_to request.referrer
  end

  private

  def event_class
    request.format.symbol == :json ? Event : Event.custom
  end
end
