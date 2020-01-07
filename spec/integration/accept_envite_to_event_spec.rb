# frozen_string_literal: true

require 'rails_helper'

feature 'Sending event invites' do
  let(:creator) { create(:user) }
  let(:invitee1) { create(:user) }
  let(:invitee2) { create(:user) }
  let(:event10) { create(:event, creator_id: creator.id) }
  let(:event20) { create(:event, creator_id: creator.id) }

  scenario 'user can acept the received event invite at its page, invite other users and cancel attendance to event' do
    invitee1.save
    invitee2.save
    login creator
    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee1.id}']").click
    expect do
      click_button 'Invite user to Event'
    end.to change(Invite, :count).by(1)

    click_link 'Sign-off'
    login invitee1

    visit user_path(invitee1)

    expect(page).to have_content("#{event10.title}")
    find(".invites input#event-#{event10.id}").click

    expect(page).to have_content('You are now attending this event!')

    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee2.id}']").click
    find('#attending', text: invitee1.name)

    click_link 'Cancel presence'

    expect { page.find(:xpath, "//option[@value='#{invitee2.id}']") }.to raise_error(Capybara::ElementNotFound)
  end
end
