class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @current_user = current_user
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
    @users = User.all_but(current_user.id)
    @event = Event.find(params[:id])
    @host = User.find(@event.creator_id)
    @event.invites.delete_expired
  end

  def index
    @events = Event.all
    @upcoming = Event.upcoming_events
    @previous = Event.prev_events
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
