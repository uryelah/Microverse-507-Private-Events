# frozen_string_literal: true

require 'rails_helper'

feature 'Sending event invites' do
  let(:creator) { create(:user) }
  let(:invitee1) { create(:user) }
  let(:invitee2) { create(:user) }
  let(:event10) { create(:event, creator_id: creator.id) }
  let(:event20) { create(:event, creator_id: creator.id) }

  scenario 'user can invite other users to created event page' do
    invitee1.save
    invitee2.save
    login creator
    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee1.id}']").click
    expect do
      click_button 'Invite user to Event'
    end.to change(Invite, :count).by(1)

    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee2.id}']").click
    expect do
      click_button 'Invite user to Event'
    end.to change(Invite, :count).by(1)
  end

  scenario 'user can\'t invite users already invited to created event' do
    invitee1.save
    invitee2.save
    login creator
    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee1.id}']").click
    click_button 'Invite user to Event'

    visit event_path(event10)

    page.find(:xpath, "//option[@value='#{invitee2.id}']").click
    click_button 'Invite user to Event'

    visit event_path(event10)

    page.find(:xpath, "//option").text == 'No user left to inivte'
  end

  scenario 'user can\'t invite itself to it\'s created event' do
    login creator
    visit event_path(event10)

    visit event_path(event10)

    page.find(:xpath, "//option").text == 'No user left to inivte'
  end

  scenario 'user can see the received event invite at its page' do
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

    visit user_path( invitee1)

    expect(page).to have_content(event10.title)
  end
end