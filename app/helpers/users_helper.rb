# frozen_string_literal: true

module UsersHelper
  def user_invite_form(user)
    return unless current_user != user

    render 'invites/send_invite_form', type: 'events', user: @user, events: current_user.hosted_events
  end

  def user_header(user)
    if current_user != user
      "#{user.name}'s page".html_safe
    else
      'My page'.html_safe
    end
  end
end
