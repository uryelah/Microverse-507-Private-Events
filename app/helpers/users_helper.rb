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
end
