# frozen_string_literal: true

# rubocop:disable Style/StringLiterals, Rails/OutputSafety
module InvitesHelper
  def user_form(users, event)
    form_start = '<form action="/invites" method="POST" accept-charset="UTF-8">'
    token = '<input type="hidden" name="authenticity_token"
      value="R4lNLK+6Z3CvV4okmGyIiwi0nya8OcNvs3vG+5imQGn93TPpwDKG5dF3vNYZj4iLGFYIa29WoaTTLfh/bLO+gw==">'
    hidden = "<input type=\"hidden\" name=\"invite[event_id]\" value=\"#{event.id}\">"
    select_start = "<select name=\"invite[user_id]\">"
    options = []
    select_end = "</select>"
    submit = "<input type=\"submit\" name=\"commit\" value=\"Invite user to Event\"
      data-disable-with=\"Invite user to Event\">"
    form_end = '</form>'

    users.each do |user|
      options << "<option value=\"#{user.id}\">#{user.name}</option>" unless user.attended_event.exists?(event.id)
    end
    if options.empty?
      options = ["<option class=\"inactive\">No user left to invite</option>"]
      select_start = "<select name=\"invite[user_id]\" disabled>"
    end
    (form_start + token + hidden + select_start + options.join(',') + select_end + submit + form_end).html_safe # rubocop:disable Rails/OutputSafety
  end

  def event_form(events, user)
    form_start = '<form action="/invites" method="POST" accept-charset="UTF-8">'
    token = '<input type="hidden" name="authenticity_token"
      value="R4lNLK+6Z3CvV4okmGyIiwi0nya8OcNvs3vG+5imQGn93TPpwDKG5dF3vNYZj4iLGFYIa29WoaTTLfh/bLO+gw==">'
    hidden = "<input type=\"hidden\" name=\"invite[user_id]\" value=\"#{user.id}\">"
    select_start = "<select name=\"invite[event_id]\">"
    options = []
    select_end = "</select>"
    submit = "<input type=\"submit\" name=\"commit\" value=\"Invite this user to Events\"
      data-disable-with=\"Invite user to Event\">"
    form_end = '</form>'

    events.each do |event|
      options << "<option value=\"#{event.id}\">#{event.title}</option>" unless event.attendees.exists?(user.id) ||
                                                                                event.date < Time.current
    end
    if options.empty?
      options = ["<option class=\"inactive\">No active events available</option>"]
      select_start = "<select name=\"invite[event_id]\" disabled>"
    end
    (form_start + token + hidden + select_start + options.join(',') + select_end + submit + form_end).html_safe # rubocop:disable Rails/OutputSafety
  end

  def user_invites(user, events, is_current_user, invites)
    content_tag :div do
      events.collect.with_index do |event, i|
        concat(content_tag(:p, (link_to event.title, event_path(event))) +
        content_tag(:p, "#{event.date.strftime('%d/%m/%Y')} - #{event.location}") +
        content_tag(:p, event.description) +
        if is_current_user
          form_for :invites do |f|
            f.submit 'submits form bellow, only works with both for some reason'
          end
          "<form action='/invites/#{invites[i]}' accept-charset=\"UTF-8\" method=\"post\">
          <input type=\"hidden\" name=\"_method\" value=\"PATCH\">
            <input type=\"hidden\" name=\"authenticity_token\"
            value=\"uiIklTGTY8/kKdSinTxsV+AgP2GxGM7cahNHO/3lM6VNQEG72XdcHQsUQWz/QbUQej5Wh9E7HpC/SJZrdOtarw==\">
          <input value=\"#{event.id}\" name=\"invite[event_id]\" type=\"hidden\" id=\"invites_event_id\">
          <input value=\"#{user.id}\" name=\"invite[user_id]\" type=\"hidden\" id=\"invites_user_id\">
          <input type=\"submit\" name=\"commit\" value=\"Confirm your presence\"
            data-disable-with=\"Confirm your presence\">
          </form>".html_safe
        else
          ''
        end +
        content_tag(:hr))
      end
    end
  end
end

# rubocop:enable Style/StringLiterals, Rails/OutputSafety
