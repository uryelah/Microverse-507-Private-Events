# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user2) { build(:user, name: '', email: '') }
  let(:user3) { build(:user, email: user.email ) }

  context 'Test model presence and validation' do
    it 'Tests if model is valid' do
      expect(user).to be_valid
    end

    it 'Test if user without name and email columns is invalid' do
      expect(user2.save).to be false
    end

    it 'Tests if user with non-unique email is invalid' do
      
      expect(user3.valid?).to be false
    end
  end
end
