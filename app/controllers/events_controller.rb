class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @current_user = User.first
    @event = @current_user.hosted_events.build(event_params)

    if @event.save
      flash[:success] = 'Event successfully created'
      redirect_to @event
    else
      flash.now[:error] = 'Error saving new event :-('
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @host = User.find(@event.creator_id)
  end

  def index
    @events = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
