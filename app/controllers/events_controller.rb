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
    @users = User.where('id != ?', current_user.id)
    @event = Event.find(params[:id])
    @host = User.find(@event.creator_id)
    @event.invites.delete_expired
    @confirmed_attendees = User.joins(:invites).where(invites: { status: true, event_id: @event.id })
    @invited_attendees = User.joins(:invites).all
    @envited = current_user.attended_event.exists?(@event.id) && Invite.find_by(user_id: current_user.id, event_id: @event.id).status == false
    @attending = current_user.attended_event.exists?(@event.id) && Invite.find_by(user_id: current_user.id, event_id: @event.id).status == true
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
