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
    @user.invites.delete_expired
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
end
