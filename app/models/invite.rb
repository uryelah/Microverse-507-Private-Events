class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_create :check_invite_exists

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

  private

  def check_invite_exists
    @invite = Invite.find_by(user_id: user_id, event_id: event_id)
    throw :abort if @invite
  end
end
