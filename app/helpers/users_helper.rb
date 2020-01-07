# frozen_string_literal: true

module UsersHelper
  def user_invite_form(user)
    return unless current_user != user

    render 'invites/send_invite_form', type: 'events', user: user, events: current_user.hosted_events
  end

  def user_header(user)
    if current_user != user
      "#{user.name}'s page".html_safe # rubocop:disable Rails/OutputSafety
    else
      'My page'.html_safe
    end
  end

  def event_list(hosted_events, is_current_user = nil, invitables = nil)
    content_tag :div do
      hosted_events.collect.with_index do |event, i|
        concat(content_tag(:p, (link_to event.title, event_path(event))) +
        content_tag(:p, "#{event.date.strftime('%d/%m/%Y')} - #{event.location}") +
        content_tag(:p, event.description) +
        if is_current_user
          render 'invites/send_invite_form', type: 'users', users: invitables[i], event: event
        else
          ''
        end +
        content_tag(:hr))
      end
    end
  end

  def users_list(users, c_u_events = nil)
    content_tag :main do
      users.collect do |user|
        next if user == current_user

        concat(content_tag(:hr) +
          content_tag(:p, (link_to user.name, user_path(user))) +
          if c_u_events
            render 'invites/send_invite_form', type: 'events', user: user, events: c_u_events
          else
            ''
          end)
      end
    end
  end
end
