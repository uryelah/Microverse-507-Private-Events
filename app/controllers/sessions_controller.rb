class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(session_params)

    if @user
      sign_in(@user)
      flash[:success] = 'User successfully logged in'
      redirect_to events_path
    else
      flash.now[:error] = 'Incorrect email or name'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :email)
  end
end
