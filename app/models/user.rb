class User < ApplicationRecord
  has_many :hosted_events, foreign_key: 'creator_id', class_name: 'Event', dependent: :nullify
  has_many :invites, dependent: :destroy
  has_many :attended_event, through: :invites, foreign_key: 'user_id', class_name: 'Event', source: :event

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :name, presence: true

  # class methods
  def self.confirmed_users(event)
    User.joins(:invites).where(invites: { status: true, event_id: event.id })
  end

  def self.invited(event)
    User.joins(:invites).where(invites: { event_id: event.id })
  end

  def self.all_but(user_id)
    User.where('id != ?', user_id)
  end
end
