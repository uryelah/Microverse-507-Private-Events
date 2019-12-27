# frozen_string_literal: true

module EventsHelper
  def events_list(events, invites_status = nil)
    content_tag :div do
      events.collect.with_index do |event, i|
        concat(content_tag(:hr) +
          content_tag(:p, (link_to event.title.to_s + ' - ' + event.date.strftime("%d/%m/%Y"), event_path(event))) + 
          if invites_status && invites_status[i]
            render "invites/confirm_invite_form", event: event
          else
            ''
          end
          )
      end
    end
  end

  def create_event_prompt(upcoming, previous)
    if upcoming.none? && previous.none?
      content_tag(:p, (link_to 'No events yet... Create the first one!', new_event_path), class: 'create')
    else
      content_tag(:p, (link_to 'Create a new event', new_event_path), class: 'create')
    end
  end

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
