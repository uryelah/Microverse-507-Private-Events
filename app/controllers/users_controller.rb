class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email], name: params[:name])

    if @user.save
      flash[:success] = "Success Sign Up"
      redirect_to @user
    else
      flash.now[:error] = "There is a problem"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
