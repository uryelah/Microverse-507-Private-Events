# frozen_string_literal: true

module EventsHelper
  def events_list(events, invites_status = nil)
    content_tag :div do
      events.collect.with_index do |event, i|
        concat(content_tag(:hr) +
          content_tag(:p, (link_to event.title.to_s + ' - ' + event.date.strftime('%d/%m/%Y'), event_path(event))) +
          if invites_status && invites_status[i]
            render 'invites/confirm_invite_form', event: event
          else
            ''
          end)
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

  def confirm_or_cancel_presence(present_event, invited = nil, attending = nil)
    if invited
      render 'invites/confirm_invite_form', event: present_event
    elsif attending
      link_to 'Cancel presence', invite_path(present_event.invites.find_by(user_id: current_user.id, event_id: present_event.id).id), data: {:confirm => 'Are you sure?'}, :method => :delete
    end
  end

  def invite_if_attending(event, host, attending = nil, users)
    return unless host == current_user || attending

    render 'invites/send_invite_form', type: 'users', users: users, event: event
  end

  def event_attendees(event, confirmed_attendees, invited_attendees)
    if event.date&. < Time.current
      content_tag(:h2, pluralize(confirmed_attendees.count, 'users') + ' attended this event') +
        attendee_list(confirmed_attendees)
    else
      content_tag(:section, (
        content_tag(:h2, 'Attending users(' + confirmed_attendees.count.to_s + ')') +
        attendee_list(confirmed_attendees) +
        content_tag(:h2, 'Invited users(' + invited_attendees.count.to_s + ')') +
        attendee_list(invited_attendees)
      ), id: 'attending')
    end
  end

  def attendee_list(users)
    content_tag :div do
      users.collect do |user|
        concat(content_tag(:hr) + content_tag(:p, (link_to user.name, user_path(user))))
      end
    end
  end
end
