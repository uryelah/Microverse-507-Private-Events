# frozen_string_literal: true

require 'rails_helper'

feature 'User signup' do
  let(:user) { build(:user) }

  scenario 'user sign up with valid data' do
    visit new_user_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email

    expect do
      click_button 'Sign up'
    end.to change(User, :count).by(1)
  end

  scenario 'user sign up with invalid data' do
    visit new_user_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: ''

    click_button 'Sign up'
    
    expect(page).to have_content('Error saving new user :-(')
  end
end