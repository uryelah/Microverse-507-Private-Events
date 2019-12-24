class InvitesController < ApplicationController
  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      flash[:success] = 'Invite successfully sent'
      redirect_to event_path(Event.find(params[:invite][:event_id]))
    else
      flash[:error] = 'Error sending invite :-('
      redirect_to users_path
    end
  end

  def destroy

  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :event_id)
  end
end
