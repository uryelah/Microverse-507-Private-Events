# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.create(:event) }
	let(:event2) { FactoryBot.build(:event, creator_id: 1000) }
	let(:event3) { FactoryBot.create(:event) }

  context 'Test model presence and validation' do
    it 'Tests if model is valid' do
      expect(event).to be_valid
    end

    it 'Test if event with invalid creator id is invalid' do
    	expect(event2.save).to be false
		end
		
		it 'Test if event without title is invalid' do
			event3.title = ''
			expect(event3.valid?).to be false
			event3.title = 'title'
		end
		
		it 'Test if event without description is invalid' do
			event3.description = ''
			expect(event3.valid?).to be false
			event3.description = 'description'
		end
		
		it 'Test if event without location is invalid' do
			event3.location = ''
			expect(event3.valid?).to be false
			event3.location = 'location'
		end
		
		it 'Test if event without date is invalid' do
			event3.date = ''
			expect(event3.valid?).to be false
			event3.date = Time.current + 1.day
    end
  end
end
