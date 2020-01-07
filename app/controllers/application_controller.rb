# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def sign_in(user)
    cookies.permanent[:signed_user] = user.id
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:signed_user)
  end

  def retrive_user_cookie
    begin
      user = User.find(cookies[:signed_user])
    rescue ActiveRecord::RecordNotFound
      cookies.delete(:signed_user)
    end
    return User.find(cookies[:signed_user]) if user && cookies[:signed_user]
  end

  def current_user
    @current_user ||= retrive_user_cookie
  end

  helper_method :current_user
end
