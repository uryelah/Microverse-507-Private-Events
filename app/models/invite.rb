class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # class methods
  def self.delete_expired
    Invite.where('status = ?', false).joins(:event).where('events.date < ?', Time.current).destroy_all
  end
end
