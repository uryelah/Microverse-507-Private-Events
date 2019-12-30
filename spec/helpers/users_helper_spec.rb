# frozen_string_literal: true

require 'rails_helper'

def login(user)
  visit login_path
  fill_in 'Name', with: user.name
  fill_in 'Email', with: user.email
  click_button 'Sign in'
end
