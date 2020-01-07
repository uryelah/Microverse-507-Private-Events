# frozen_string_literal: true

require 'rails_helper'

feature 'Event creation login' do
  let(:user) { create(:user) }
  let(:event) { build(:event) }

  scenario 'event creation with valid data' do
    login user
    visit new_event_path
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    fill_in 'Date', with: event.date
    fill_in 'Location', with: event.location

    expect do
      click_button 'Submit event'
    end.to change(Event, :count).by(1)
  end

  scenario 'event creation with invalid data' do
    login user
    visit new_event_path
    fill_in 'Title', with: ''
    fill_in 'Description', with: event.description
    fill_in 'Date', with: event.date
    fill_in 'Location', with: event.location
    
    click_button 'Submit event'

    expect(page).to have_content('Error saving new event :-(')
  end

  scenario 'After valid event creation it redirects to event page' do
    login user
    visit new_event_path
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    fill_in 'Date', with: event.date
    fill_in 'Location', with: event.location

    click_button 'Submit event'
    expect(page).to have_content(event.title + ' - event page')
  end

  scenario 'After valid event creation it get\' included to the events index page' do
    login user
    visit new_event_path
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    fill_in 'Date', with: event.date
    fill_in 'Location', with: event.location

    click_button 'Submit event'

    visit events_path

    expect(page).to have_content(event.title + ' - ' + event.date.strftime('%d/%m/%Y'))
  end

  scenario 'After valid event creation it get\'s included to the creator user page' do
    login user
    visit new_event_path
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    fill_in 'Date', with: event.date
    fill_in 'Location', with: event.location

    click_button 'Submit event'

    visit user_path(user.id)

    expect(page).to have_content(event.title)
  end
end