# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :logged?

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
    @event = Event.find(params[:id])
    @users = any_invitables(current_user, @event.creator)
    @host = User.find(@event.creator_id)
    @event.invites.delete_expired
    @confirmed_attendees = User.confirmed_users(@event)
    @invited_attendees = User.invited(@event)
    @current_user_invited = current_user.attended_event.exists?(@event.id) &&
                            Invite.find_invite(current_user.id, @event.id, false)
    @current_user_attending = current_user.attended_event.exists?(@event.id) &&
                              Invite.find_invite(current_user.id, @event.id, true)
  end

  def index
    @events = Event.all
    @upcoming = Event.upcoming_events
    @previous = Event.prev_events
    @upcoming_invites = current_user_invited(@upcoming)
  end

  private

  def logged?
    redirect_to login_path unless current_user
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end

  def any_invitables(current_user, event_creator)
    User.all_but(current_user, event_creator)
  end

  def current_user_invited(events)
    invited_arr = []
    events.each do |event|
      pending_invite = Invite.find_invite(current_user.id, event.id, false)
      if pending_invite # rubocop :disable Style/ConditionalAssignment
        invited_arr << true
      else
        invited_arr << false
      end
    end
    invited_arr
  end
end
