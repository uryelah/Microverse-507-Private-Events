class UsersController < ApplicationController
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
    @users = User.where('id != ?', @user.id)
    @user.invites.delete_expired
    @attending = Event.upcoming_events.joins(:invites).where(invites: { status: true, user_id: @user.id })
    @invited = Event.upcoming_events.joins(:invites).where(invites: { status: false, user_id: @user.id })
    @attended = Event.prev_events.joins(:invites).where(invites: { status: true, user_id: @user.id })
  end

  def index
    @users = User.all
    @c_u_events = current_user.hosted_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
