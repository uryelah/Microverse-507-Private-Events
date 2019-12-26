# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :logged?

  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      flash[:success] = 'Invite successfully sent'
      redirect_to event_path(Event.find(params[:invite][:event_id]))
    else
      flash[:error] = 'This user was already invited'
      redirect_to request.referer
    end
  end

  def update
    @invite = Invite.find_invite(params[:invite][:user_id], params[:invite][:event_id], false)
    if @invite&.update(status: true)
      flash[:success] = 'You are now attending this event!'
      redirect_to event_path(params[:invite][:event_id])
    else
      flash[:error] = 'Error updating invite :-('
      redirect_to request.referer
    end
  end

  def destroy
    @invite = Invite.find_by(id: params[:id])
    if @invite.destroy
      flash[:success] = 'You are no longer invited to this event... good grief!'
      redirect_to events_path
    else
      flash[:error] = 'Error canceling attendance... I guess you have to go now!'
      redirect_to request.referer
    end
  end

  private

  def logged?
    redirect_to login_path unless current_user
  end

  def invite_params
    params.require(:invite).permit(:user_id, :event_id)
  end
end
