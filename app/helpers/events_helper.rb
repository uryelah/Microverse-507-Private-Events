# frozen_string_literal: true

module EventsHelper
  def confirmed_attendees(event)
    User.confirmed_users(event)
  end

  def invited_attendees(event)
    User.invited(event)
  end

  def current_user_attending?(event)
    current_user.attended_event.exists?(event.id) &&
      Invite.find_invite(current_user.id, event.id, true)
  end

  def current_user_invited?(event)
    current_user.attended_event.exists?(event.id) &&
      Invite.find_invite(current_user.id, event.id, false)
  end
end
