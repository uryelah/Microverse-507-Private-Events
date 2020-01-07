# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invite, type: :model do
  let(:invite) { FactoryBot.create(:invite) }
  let(:invite2) { FactoryBot.build(:invite, user_id: 1000) }
  let(:rep_inivte) { FactoryBot.build(:invite, user_id: invite.user_id, event_id: invite.event_id) }

  context 'Test model presence and validation' do
    it 'Tests if model is valid' do
      expect(invite).to be_valid
    end

    it 'Tests if model with invalid foreigner key is invalid' do
      expect(invite2.save).to be false
    end

    it 'Tests if invite for past event is invalid' do
      past_event = FactoryBot.create(:event, date: Time.current - 1.day)
      invite3 = FactoryBot.build(:invite, event_id: past_event.id)
      expect(invite3.save).to be false
    end

    it 'Tests if repeated invite is not saved' do
      expect(rep_inivte.save).to be false
    end

    it 'Tests if invite is destroyed if it\'s user is destroyed' do
      user = FactoryBot.create(:user, name: 'Sherlock')
      rip_invite = FactoryBot.create(:invite, user_id: user.id)
      user.destroy
      expect { Invite.find(rip_invite.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'Tests if invite is destroyed if it\'s event is destroyed' do
      event = FactoryBot.create(:event, title: 'The Adventure of the Final Problem')
      rip_invite = FactoryBot.create(:invite, event_id: event.id)
      event.destroy
      expect { Invite.find(rip_invite.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
