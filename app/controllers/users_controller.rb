# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'User successfully created'
      redirect_to @user
    else
      flash.now[:error] = 'Error saving new user :-('
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @hosted_events = @user.hosted_events
    @user.invites.delete_expired
    @attending_to = Event.attending_to(@user)
    @invited_to = Event.invited_to(@user)
    @attended_to = Event.attended_to(@user)
    @is_current_user = current_user?(@user)
    @invites = Invite.find_invite_id(current_user, @invited_to)
    @invitables = invitables(@hosted_events)
  end

  def index
    @users = User.all
    @c_u_events = current_user.hosted_events
  end

  private

  def logged?
    redirect_to login_path unless current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def invitables(events)
    invitable_arr = []
    events.each do |event|
      invitable_arr << invitable_users(current_user, event.creator)
    end
    invitable_arr
  end

  def invitable_users(user, host)
    User.all_but(user, host)
  end

  def current_user?(user)
    User.find(cookies[:signed_user])&. == user
  end
end
