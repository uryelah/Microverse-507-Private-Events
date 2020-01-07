# frozen_string_literal: true

require 'rails_helper'

feature 'User login' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  scenario 'Checks if user can login with valid data' do
    login user
    visit events_path
    expect(page).to have_content('All Events')
  end

  scenario 'Check if cookie was created after user login' do
    login user
    cookie_value = get_me_the_cookie('signed_user')[:value].to_i
    expect(cookie_value).to eq(user.id)
  end

  scenario "Checks if user can't login with invalid data" do
    user.email = '123@bla.'
    login user
    expect(page).to have_content('Incorrect email or name')
  end

  scenario 'Checks if user is logged out' do
    login user
    click_link 'Sign-off'
    visit events_path
    expect(page).to have_content('Login')
  end

  scenario 'Checks if not logged-in user can only access the login path' do
    result = true
    
    visit events_path
    if page.has_content?('All Events')
      result = false
    end
    visit new_event_path
    if page.has_content?('New Event')
      result = false
    end
    visit user_path(1)
    if page.has_content?('email:')
      result = false
    end
    visit event_path(1)
    if page.has_content?('event page')
      result = false
    end
    visit new_user_path
    unless page.has_content?('Sign Up')
      result = false
    end
    expect(result).to be true
    
  end

  scenario 'Check if cookie is deleted after user logout' do
    login user
    click_link 'Sign-off'
    visit login_path
    cookie_value = get_me_the_cookie('signed_user')[:value].to_i
    expect(cookie_value).to be_zero
  end
end