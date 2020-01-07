# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_create :check_invite_exists, :check_if_self_invite

  validate :event_is_upcoming

  # scopes
  scope :ivt_status, ->(bool) { where('status = ?', bool) }
  scope :past, ->(time) { where('events.date < ?', time) }

  # class methods
  def self.delete_expired
    Invite.ivt_status(false).joins(:event).past(Time.current).destroy_all
  end

  def self.find_invite(user_id, event_id, status)
    Invite.find_by(user_id: user_id, event_id: event_id, status: status)
  end

  def self.find_invite_id(user_id, events)
    id_arr = []
    return id_arr if events.empty?

    events.each do |event|
      id_arr << event.invites.find_by(user_id: user_id, event_id: event.id)&.id
    end
    id_arr
  end

  private

  def check_invite_exists
    @invite = Invite.find_by(user_id: user_id, event_id: event_id)
    throw :abort if @invite
  end

  def check_if_self_invite
    throw :abort if Event.find(event_id).creator.id == user_id
  end

  def event_is_upcoming
    errors.add(:date, 'Cannot send envite to expired event') if event.date < Time.current
  end
end
