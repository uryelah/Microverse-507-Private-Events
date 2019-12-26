# frozen_string_literal: true

module UsersHelper
  def attending_to(user)
    Event.upcoming_events.my_ivt_status(true, user)
  end

  def invited_to(user)
    Event.upcoming_events.my_ivt_status(false, user)
  end

  def attended_to(user)
    Event.prev_events.my_ivt_status(true, user)
  end

  def invitable_users(user, host)
    User.all_but(user, host)
  end
end
